# -----------------------------------------------------------------------------
#
# Copyright (c) 2008 VMware, Inc.  All rights reserved.
#
# -----------------------------------------------------------------------------
use 5.006001;
use strict;
use warnings;


# -----------------------------------------------------------------------------
package VMware::VICredStore;


use Fcntl ':flock';
use File::Basename;
use File::Path;
use XML::LibXML;
use MIME::Base64;
use Carp;
use Exporter;
our @EXPORT_OK = qw(init get_password add_password remove_password
                    clear_passwords get_hosts get_usernames close);


use constant LOCK_READ       => 1;
use constant LOCK_WRITE      => 2;
use constant TRUE            => 1;
use constant FALSE           => 0;
use constant FLMASK_VMCS     => 077;
use constant STRING_EMPTY    => '';
use constant NODE_ROOT       => 'viCredentials';
use constant NODE_ENTRY      => 'passwordEntry';
use constant NODE_HOST       => 'host';
use constant NODE_USER       => 'username';
use constant NODE_PASS       => 'password';
use constant NODE_VER        => 'version';
use constant MODE_READ       => '<';
use constant MODE_APPEND     => '+>>';
use constant HASHMOD         => 256;
use constant MINPASSLENGTH   => 128;
use constant FILE_PATH_UNIX  => '/.vmware/credstore/vicredentials.xml';
use constant FILE_PATH_WIN   => '/VMware/credstore/vicredentials.xml';
use constant XML_VERSION     => '1.0';
use constant XML_ENCODING    => 'UTF-8';
use constant LOCKSLEEP       => 12;
use constant ERR_INVALID_ARGUMENT      => 'Invalid argument specified';
use constant ERR_FILE_NOT_FOUND        => 'File not found';
use constant ERR_OPERATION_FAILED      => 'Operation failed';
use constant ERR_PARSING_FAILED        => 'Failed to parse file';
use constant ERR_STORE_NOT_INITAILIZED => 'Credential store is not initialized';
use constant ERR_STORE_REINITIALIZED   => 'Credential store is already initialized';


my $is_inited     = FALSE;
my $store_file    = STRING_EMPTY;
my $default_path  = FALSE;


# ------------------------------------------------------------------------------
# Description: Initialize the Credential Store.
# This sub routine accepts the location of the Credential Store file. If this is
# not specified then it uses file at following location:
# $HOME/.vmware/credstore/vicredentials.xml on unix or
# %APPDATA%\VMware\credstore\vicredentials.xml on windows.
# Input: Subroutine style:
#           VICredStore::init(filename => $filename)
#        where
#           $filename   - Name of Credential store file.
# Output: 1 if initialized successfully else 0.
# ------------------------------------------------------------------------------
sub init
{
   my (%args) = @_;
   my $filename = $args{filename};

   # If is_inited is true, return Error.
   die ERR_STORE_REINITIALIZED if $is_inited;

   # Acquire the Credential strore filename
   if (!defined($filename) || "" eq $filename) {
      $filename = get_default_path();
      $default_path = TRUE;
   }

   $store_file = $filename;

   $is_inited = TRUE;

   return(TRUE);
}


# ------------------------------------------------------------------------------
# Description: Get the password for a given server and username.
# Input: Subroutine style:
#           VICredStore::get_password(server => $server, username => $username)
#        where
#           $server   - Server for entry whoes password is to be retrieved
#           $username - Username for entry whoes password is to be retrieved
# Output: The password, or undef if none is found
# ------------------------------------------------------------------------------
sub get_password
{
   my (%args) = @_;
   my $server = $args{server};
   my $username = $args{username};

   my $fh;
   my $root;
   my $entry;
   my $h_item;
   my $u_item;
   my $p_item;
   my $password = undef;

   # Check if library is inited
   die ERR_STORE_NOT_INITAILIZED unless $is_inited;

   # validate server and username
   validate_argument (argument => $server);
   validate_argument (argument => $username);

   # Lock file
   $fh = acquire_lock (filename => $store_file,
                       lock_type => LOCK_READ,
                       create_flag =>FALSE);

   # Create DOM from XML File
   eval {
      $root = get_document_root (fh => $fh);
   };
   if ($@) {
      # Unlock file
      release_lock (fh => $fh);
      die ERR_PARSING_FAILED . " for $store_file";
   }

   # Unlock file
   release_lock (fh => $fh);

   # Get obfuscated password from DOM
   $entry = find_entry_node (root => $root,
                             server => $server,
                             username => $username);
   if (defined ($entry)) {
         $h_item = $entry->findvalue (NODE_HOST);
         $u_item = $entry->findvalue (NODE_USER);
         $p_item = $entry->findvalue (NODE_PASS);

      # Decrypt password
      if (defined ($p_item)) {
         eval {
            $password = de_obfuscate (server => $h_item,
                                      username => $u_item,
                                      password => $p_item);
         };
         if ($@) {
            die ERR_PARSING_FAILED . " for $store_file";
         }
      }
   }

   return ($password);
}


# ------------------------------------------------------------------------------
# Description: Store the password for a given server and username.
# If a password already exists for that server and username, it is
# overwritten.
# If the credential store filename is not provided to VICredStore::init(),
# then a default location is used. The default location is:
# $HOME/.vmware/credstore/vicredentials.xml on unix or
# %APPDATA%\VMware\credstore\vicredentials.xml on windows.
# If the default location is used, and it does not exist,
# then this file is created. In any other case, if the specified file
# does not exist, then it is created only if its parent directory exists.
# Input: Subroutine style:
#           VICredStore::add_password(server => $server,
#                                     username => $username,
#                                     password => $password)
#        where
#           $server     - Server for the new entry.
#           $username   - Username for the new entry.
#           $password   - Password for the new entry.
# Output: Return 1 if a password for this server and user did not already exists
# else return zero
# ------------------------------------------------------------------------------
sub add_password
{
   my (%args) = @_;
   my $server = $args{server};
   my $username = $args{username};
   my $password = $args{password};

   my $fh;
   my $root;
   my $entry;
   my $found = FALSE;

   # Check if library is inited
   die ERR_STORE_NOT_INITAILIZED unless $is_inited;

   # validate server, username and password
   validate_argument (argument => $server);
   validate_argument (argument => $username);

   if (!defined ($password)) {
      croak ERR_INVALID_ARGUMENT . "\n";
   }

   # Encrypt Password
   eval {
      $password = obfuscate (server => $server,
                             username => $username,
                             password => $password);
   };
   if ($@) {
      die ERR_OPERATION_FAILED;
   }

   # Acquire lock on file for writing
   $fh = acquire_lock (filename => $store_file,
                       lock_type => LOCK_WRITE,
                       create_flag => TRUE);

   # Create DOM from XML File
   eval {
      $root = get_document_root (fh => $fh);
   };
   if ($@) {
      release_lock (fh => $fh);
      die ERR_PARSING_FAILED . " for $store_file";
   }

   # Search for entry in DOM
   $entry = find_entry_node (root => $root,
                             server => $server,
                             username => $username);

   if (defined ($entry)) {
         my @p_node = $entry->getElementsByTagName(NODE_PASS);
         $p_node[0]->getFirstChild->setData ($password);
         @p_node = $entry->getElementsByTagName (NODE_HOST);
         $p_node[0]->getFirstChild->setData ($server);
         $found = TRUE;
    } else {
       # Password entry does not exist in XML file. Add new
       $entry = create_new_entry (server => $server,
                                  username => $username,
                                  password => $password);
       if (defined ($entry)) {
         $root->appendChild ($entry);
       }
    }

   # Update XML File
   write_xml (fh => $fh, root => $root);

   # Release lock
   release_lock (fh => $fh);

   return ($found); # if password exists return 1
                    # else return 0
}


# ------------------------------------------------------------------------------
# Description: Remove the password for a given server and username.
# If no such password exists, this method has no effect.
# Input: Subroutine style:
#           VICredStore::remove_password(server => $server,
#                                        username => $username)
#        where
#           $server     - Server to be searched for.
#           $username   - Username to be searched for.
# Output: 1 if the password existed and was removed else return zero
# ------------------------------------------------------------------------------
sub remove_password
{
   my (%args) = @_;
   my $server = $args{server};
   my $username = $args{username};

   my $found = FALSE;
   my $fh;
   my $root;
   my $doc;
   my $entry;

   # Check if library is inited
   die ERR_STORE_NOT_INITAILIZED unless $is_inited;

   # Validate server and username
   validate_argument (argument => $server);
   validate_argument (argument => $username);

   # Acquire lock on file for writing
   $fh = acquire_lock (filename => $store_file,
                       lock_type => LOCK_WRITE,
                       create_flag =>FALSE);

   # Create DOM from XML File
   eval {
      $root = get_document_root (fh => $fh);
   };
   if ($@) {
      release_lock (fh => $fh);
      die ERR_PARSING_FAILED . " for $store_file";
   }

   # Search for entry in DOM
   $entry = find_entry_node (root => $root,
                             server => $server,
                             username => $username);

   if (defined ($entry)) {
      $found = TRUE;
      $root->removeChild ($entry);
      # Update XML File
      write_xml (fh => $fh, root => $root);
   }

   # Release lock
   release_lock (fh => $fh);

   return($found); # If password existed, return 1
                   # Else return 0
}


# ------------------------------------------------------------------------------
# Description: Remove all passwords.
# Input: Subroutine style:
#           VICredStore::clear_passwords
# Output:
# ------------------------------------------------------------------------------
sub clear_passwords
{
   my $fh;

   # Check if library is inited
   die ERR_STORE_NOT_INITAILIZED unless $is_inited;

   # Acquire lock on file for writing
   $fh = acquire_lock (filename => $store_file,
                       lock_type => LOCK_WRITE,
                       create_flag => FALSE);

   # Update XML File
   write_xml (fh => $fh, root => create_initial_DOM());

   # Release lock
   release_lock (fh => $fh);

   return;
}


# ------------------------------------------------------------------------------
# Description: Return list of all servers that have entries in the Credential
# Store.
# Input: Subroutine style:
#           VICredStore::get_hosts
# Output: List of all servers in the Credential Store.
# ------------------------------------------------------------------------------
sub get_hosts
{
   my @server_list;
   my $fh;
   my $root;

   # Check if library is inited
   die ERR_STORE_NOT_INITAILIZED unless $is_inited;

   # Lock file
   $fh = acquire_lock (filename => $store_file,
                       lock_type => LOCK_READ,
                       create_flag => FALSE);

   # Create DOM from XML File
   eval {
      $root = get_document_root (fh => $fh);
   };
   if ($@) {
      # Unlock file
      release_lock (fh => $fh);
      die ERR_PARSING_FAILED . " for $store_file";
   }

   # Unlock file
   release_lock (fh => $fh);

   # Iterate on each entry
   if (defined ($root)) {
      foreach my $entry ($root->findnodes (NODE_ENTRY)) {
         my $server = $entry->findvalue (NODE_HOST);
         if (!list_contains (case_sensitive => FALSE,
                             new_item => $server,
                             item_list => \@server_list)) {
            @server_list = (@server_list, $server);
         }
      }
   }
   @server_list = sort (@server_list);
   return (@server_list);
}


# ------------------------------------------------------------------------------
# Description: For a given server, return all usernames that have passwords
# stored in the Credential Store.
# Input: Subroutine style:
#           VICredStore::get_usernames(server => $server)
#        where
#           $server   - Server to be searched for.
# Output: List of all users belonging to specified server.
# ------------------------------------------------------------------------------
sub get_usernames
{
   my (%args) = @_;
   my $server = $args{server};

   my @user_list;
   my $fh;
   my $root;

   # Check if library is inited
   $is_inited or die ERR_STORE_NOT_INITAILIZED;

   # Lock file
   $fh = acquire_lock (filename => $store_file,
                       lock_type => LOCK_READ,
                       create_flag => FALSE);

   # Create DOM from XML File
   eval {
      $root = get_document_root (fh => $fh);
   };
   if ($@) {
      # Unlock file
      release_lock (fh => $fh);
      die ERR_PARSING_FAILED . " for $store_file";
   }

   # Unlock file
   release_lock (fh => $fh);

   # Iterate on each entry
   if (defined ($root)) {
      foreach my $entry ($root->findnodes (NODE_ENTRY)) {
         if (uc ($server) eq uc ($entry->findvalue (NODE_HOST))) {
            @user_list = (@user_list, $entry->findvalue (NODE_USER));
         }
      }
   }
   @user_list = sort (@user_list);
   return (@user_list);
}


# ------------------------------------------------------------------------------
# Description: Closes this Credential Store and frees all resources associated
# with it.  No further CredStore methods may be invoked on this object.
# Input: Subroutine style:
#           VICredStore::close
# Output:
# ------------------------------------------------------------------------------
sub close
{
   # Check if library is inited
   $is_inited or die ERR_STORE_NOT_INITAILIZED;

   $store_file = STRING_EMPTY;
   $is_inited  = FALSE;
   $default_path = FALSE;

   return;
}


# ------------------------------------------------------------------------------
# Description: Query the OS name.
# Input:  Subroutine style:  VICredStore::get_os
# Output: String containing name of OS.
# ------------------------------------------------------------------------------
sub get_os
{
   my $os = $^O;
   if    ($os eq 'MSWin32')  { $os = 'WINDOWS'; }
   elsif ($os =~ /vms/i)     { $os = 'VMS'; }
   elsif ($os =~ /^MacOS$/i) { $os = 'MACINTOSH'; }
   elsif ($os =~ /os2/i)     { $os = 'OS2'; }
   else                      { $os = 'UNIX'; }
   return ($os);
}


# ------------------------------------------------------------------------------
# Description: Try to acquire lock on the Credential Store file.
# The implementation may time out if the lock cannot be acquired within a
# reasonable amount of time, on the order of a minute.
# Input: Subroutine style:
#           VICredStore::acquire_lock(filename => $filename,
#                                     lock_type => $lock_type,
#                                     create_flag => $create_flag)
#        where
#           $filename    - Name of file to be locked.
#           $lock_type   - Type of lock to be acquired (LOCK_READ/LOCK_WRITE).
#           $create_flag - Create file if it does not exist (TRUE/FALSE).
# Output: File handle for locked file.
# ------------------------------------------------------------------------------
sub acquire_lock
{
   my (%args) = @_;
   my $filename = $args{filename};
   my $lock_type = $args{lock_type};
   my $create_flag = $args{create_flag};

   my $fh;
   my $mode;
   my $old_mask;
   my $timeout;
   my $init_file = FALSE;
   my $lock = Fcntl::LOCK_NB;

   if (! -e $filename) {
      if ($create_flag) {
         $init_file = TRUE;
      } else {
         die ERR_FILE_NOT_FOUND . " $filename";
      }
   }

   # Compute lock type
   if (LOCK_READ == $lock_type) {
      # Read lock / shared lock
      $lock |= Fcntl::LOCK_SH;
      $mode = MODE_READ;
   }
   elsif (LOCK_WRITE == $lock_type) {
      # write lock / exclusive lock
      $lock |= Fcntl::LOCK_EX;
      $mode = MODE_APPEND;
   } else {
      die ERR_INVALID_ARGUMENT;
   }

   if ($init_file && $default_path) {
      my ($f_name, $d_name) = fileparse($filename);
      chop ($d_name);
      if (! -d $d_name) {
         my ($current, $parent) = fileparse($d_name);
         chop ($parent);
         if (!(-d $parent)) {
            mkpath ($parent, 0) || die ERR_OPERATION_FAILED . " (mkpath $parent)\n$!";
         }
         # The default directory should have rwx permission only for
         # current user
         mkdir ($d_name, 0700) || die ERR_OPERATION_FAILED . " (mkdir $parent)\n$!";
      }
   }

   if (LOCK_WRITE == $lock_type) {
      # Credential Store files should be created with read-write permission
      # for the specified user only
      $old_mask = umask (FLMASK_VMCS);
   }

   if (!open ($fh, $mode, $filename)) {
      if (defined ($old_mask)) {
         umask ($old_mask);
      }
      die ERR_OPERATION_FAILED . " for $filename\n$!";
   }

   # Reset umask to old value
   if (defined ($old_mask)) {
      umask ($old_mask);
   }

   # Lock file: If file is already locked, then we retry the operation after
   # X amount of time, where X is initially 1, and increments by 1 after
   # failure to lock the file, untill it reaches LOCKSLEEP. In the worst case,
   # the application will sleep for (1 + 2 + ... + LOCKSLEEP) seconds, if it
   # fails to acquire lock in every attempt.
   $timeout = 1;
   while (LOCKSLEEP >= $timeout) {
      if (flock ($fh, $lock)) {
         last;
      }
      sleep ($timeout);
      $timeout ++;
   }

   if (LOCKSLEEP < $timeout) {
      # Failed to acquire lock after many retries.
      CORE::close ($fh);
      die ERR_OPERATION_FAILED . "\n$!";
   }

   if ($init_file) {
      write_xml (fh => $fh, root => create_initial_DOM());
   }

   if (!seek ($fh, 0, 0)) {
      release_lock (fh => $fh);
      die ERR_OPERATION_FAILED . "\n$!";
   }

   return $fh;
}


# ------------------------------------------------------------------------------
# Description: Release lock on file handle.
# Input: Subroutine style:
#           VICredStore::release_lock(fh => $fh)
#        where
#           $fh         - Handle of locked file.
# Output:
# ------------------------------------------------------------------------------
sub release_lock
{
   my (%args) = @_;
   my $fh = $args{fh};

   # Unlock file handle
   if (!flock ($fh, Fcntl::LOCK_UN)) {
      CORE::close ($fh);
      die ERR_OPERATION_FAILED . "\n$!";
   }

   # Close file handle
   if (!CORE::close ($fh)) {
      die ERR_OPERATION_FAILED . "\n$!";
   }

   return;
}


# ------------------------------------------------------------------------------
# Description: Load XML as DOM into memory and return it's root node.
# Input: Subroutine style:
#           VICredStore::get_document_root(fh => $fh)
#        where
#           $fh         - Handle to the XML file.
# Output: Root node for the DOM.
# ------------------------------------------------------------------------------
sub get_document_root
{
   my (%args) = @_;
   my $fh = $args{fh};

   my $parser = XML::LibXML->new();
   $parser->keep_blanks(0);
   my $doc = $parser->parse_fh($fh);
   my $root = $doc->getDocumentElement;
   return $root;
}


# ------------------------------------------------------------------------------
# Description: Compute hash code for specified string.
# Input: Subroutine style:
#           VICredStore::hash_code(input_string => $input_string)
#        where
#           $string     - String for which hash code has to be computed.
# Output: Hash code of input string.
# ------------------------------------------------------------------------------
sub hash_code
{
   use integer;

   my (%args) = @_;
   my $input_string = $args{input_string};

   my $hash = 0;
   my $boundary = 0x7FFFFFFF;
   my $negative = 0x80000000;

   # hash = s[0]*31^(n-1) + s[1]*31^(n-2) + ... + s[n-1]
   foreach(split(//, $input_string)) {
      $hash = ($hash) * 31 + ord ($_);

      # hash is 32 bit. On 64-bit platform, integer is 64 bit. So to emulate
      # 32-bit integer behavior, the sign bit should be applied for bits
      # 32 to 64.
      if($hash & $negative) {
         $hash |= ~$boundary;
      } else {
         $hash &= $boundary;
      }
   }
   return $hash;
}


# ------------------------------------------------------------------------------
# Description: Generate random string.
# Input: Subroutine style:
#           VICredStore::generate_random_string(string_length => $string_length)
#        where
#           $string_length - Length of the string.
# Output: Random string of specified length.
# ------------------------------------------------------------------------------
sub generate_random_string
{
   my (%args) = @_;
   my $string_length = $args{string_length};

   my @chars=('a'..'z','A'..'Z','0'..'9','_');
   my $str = "";

   foreach (1..$string_length) {
      $str .= $chars[rand @chars];
   }

   return $str;
}


# ------------------------------------------------------------------------------
# Description: Obfuscate the password using server and username.
# Input: Subroutine style:
#           VICredStore::obfuscate(server => $server,
#                                  username => $username,
#                                  password => $password)
#        where
#           $server   - Server to be used for obfuscation.
#           $username - User name to be used for obfuscation.
#           $password - Password string to be obfuscated.
# Output: Obfuscated password string.
# ------------------------------------------------------------------------------
sub obfuscate
{
   use integer;

   my (%args) = @_;
   my $server = $args{server};
   my $username = $args{username};
   my $password = $args{password};

   my $hash;
   my $crypt;
   my $length;

   $length = length ($password);
   if (MINPASSLENGTH > $length) {
      $length = MINPASSLENGTH;
   }
   eval {
      # Length of obfucated password should be alteast 128 characters. If password
      # length is lesser, then append random string to it to increase it's length
      # to 128 characters. Password is delmited by NULL character.
      $password .= "\0";
      $password .= generate_random_string
                   (string_length => $length - length ($password) - 1);

      # Every character of password is XORed with one byte hashcode.
      $hash = hash_code (input_string => $server . $username) % HASHMOD;
      $crypt = chr ($hash & 0xFF) x $length;
      $password ^= $crypt;

      # Password string is base64 encoded.
      $password = encode_base64 ($password, "");
   };
   if ($@) {
      die ERR_OPERATION_FAILED;
   }
   return ($password);
}


# ------------------------------------------------------------------------------
# Description: Deobfuscate the specified string using server and username
# Input: Subroutine style:
#           VICredStore::de_obfuscate(server => $server,
#                                     username => $username,
#                                     password => $password)
#        where
#           $server   - Server to be used for de-obfucation.
#           $username - User name to be used for de-obfucation
#           $password - Obfuscated password string.
# Output: De-obfuscated password as a string.
# ------------------------------------------------------------------------------
sub de_obfuscate
{
   use integer;

   my (%args) = @_;
   my $server = $args{server};
   my $username = $args{username};
   my $password = $args{password};

   my $hash;
   my $crypt;
   my $ind;

   validate_argument (argument => $password);

   eval {
      # Password is base 64 encoded. Hence base 64 decode it.
      $password = decode_base64 ($password);

      # XOR every character with hash to get back original password.
      $hash = hash_code (input_string => $server . $username) % HASHMOD;
      $crypt = chr ($hash & 0xFF) x length ($password);
      $password ^= $crypt;

      # Password is delimited by NULL.
      $ind = index ($password, "\0");
      if (-1 == $ind) {
         die ERR_OPERATION_FAILED;
      }
      $password = substr ($password, 0, $ind);
   };
   if ($@) {
      die ERR_OPERATION_FAILED;
   }
   return ($password);
}


# ------------------------------------------------------------------------------
# Description: Create initial DOM tree in memory.
# Input: Subroutine style:
#           VICredStore::create_initial_DOM()
# Output: Root node of initialized DOM.
# ------------------------------------------------------------------------------
sub create_initial_DOM
{
   # Create Root node and Version node.
   my $root = XML::LibXML::Element->new (NODE_ROOT);
   my $v_node = XML::LibXML::Element->new (NODE_VER);
   $v_node->appendChild(XML::LibXML::Text->new (XML_VERSION));
   $root->appendChild ($v_node);
   return ($root);
}


# ------------------------------------------------------------------------------
# Description: Create a DOM node.
# Input: Subroutine style:
#           VICredStore::create_new_entry(server => $server,
#                                         username => $username,
#                                         password => $password)
#        where
#           $server   - Server.
#           $username - User name.
#           $password - Password.
# Output: Node containing specified server, username and password.
# ------------------------------------------------------------------------------
sub create_new_entry
{
   my (%args) = @_;
   my $server = $args{server};
   my $username = $args{username};
   my $password = $args{password};

   my $e_node;
   my $h_node;
   my $u_node;
   my $p_node;

   # Create server node, username node and password node and append then to
   # entry node.
   $e_node = XML::LibXML::Element->new (NODE_ENTRY);

   $h_node = XML::LibXML::Element->new (NODE_HOST);
   $h_node->appendChild(XML::LibXML::Text->new($server));
   $e_node->appendChild ($h_node);

   $u_node = XML::LibXML::Element->new (NODE_USER);
   $u_node->appendChild(XML::LibXML::Text->new($username));
   $e_node->appendChild ($u_node);

   $p_node = XML::LibXML::Element->new (NODE_PASS);
   $p_node->appendChild(XML::LibXML::Text->new($password));
   $e_node->appendChild ($p_node);

   return ($e_node);
}


# ------------------------------------------------------------------------------
# Description: Find entry in DOM.
# Input: Subroutine style:
#           VICredStore::find_entry_node(root => $root,
#                                        server => $server,
#                                        username => $username)
#        where
#           $root     - Root node of DOM.
#           $server   - Server to be used for searching.
#           $username - Username to be used for searching.
# Output: Node with specified server and username.
# ------------------------------------------------------------------------------
sub find_entry_node
{
   my (%args) = @_;
   my $root = $args{root};
   my $server = $args{server};
   my $username = $args{username};

   if (!defined ($root)) {
      return (undef);
   }

   foreach my $entry ($root->findnodes (NODE_ENTRY)) {
      #Server search is case insensitive.
      if (uc ($server) eq uc ($entry->findvalue (NODE_HOST)) &&
          $username eq $entry->findvalue (NODE_USER)) {
         return ($entry);
      }
   }

   return (undef);
}


# ------------------------------------------------------------------------------
# Description: Check if specified string is not defined or empty
# Input: Subroutine style:
#           VICredStore::validate_argument(argument => $argument)
#        where
#           $argument   - String to be validated.
# Output: Is specified string not defined or empty (FALSE/TRUE).
# ------------------------------------------------------------------------------
sub validate_argument
{
   my (%args) = @_;
   my $argument = $args{argument};

   if (!defined ($argument) || "" eq $argument) {
      croak ERR_INVALID_ARGUMENT . "\n";
   }
}


# ------------------------------------------------------------------------------
# Description: Write DOM to XML file.
# Input: Subroutine style:
#           VICredStore::write_xml(fh => $fh,
#                                  root => $root)
#        where
#           $fh         - Handle of file to be written to.
#           $root       - Root node of DOM.
# Output:
# ------------------------------------------------------------------------------
sub write_xml
{
   my (%args) = @_;
   my $fh = $args{fh};
   my $root = $args{root};

   my $doc = XML::LibXML::Document->new (XML_VERSION, XML_ENCODING);
   $doc->setDocumentElement ($root);

   # Erase old contents
   truncate ($fh, 0);

   # Pretty Printing XML
   $doc->toFH ($fh, 1);

   return;
}


# ------------------------------------------------------------------------------
# Description: Check if list contains specified item.
# Input: Subroutine style:
#           VICredStore::list_contains(case_sensitive => $case_sensitive,
#                                      new_item => $new_item,
#                                      item_list => \@item_list)
#        where
#           $case_sensitive - Check is case-sensitive (TRUE/FALSE).
#           $new_item       - Item to be searched for.
#           @item_list      - List to be searched.
# Output: TRUE if item is found in list, else FALSE
# ------------------------------------------------------------------------------
sub list_contains
{
   my (%args) = @_;
   my $case_sensitive = $args{case_sensitive};
   my $new_item = $args{new_item};
   my $item_list = $args{item_list};

   foreach my $item (@$item_list) {
      if ($case_sensitive) {
         if ($item eq $new_item) {
            return (TRUE);
         }
      } elsif (uc ($item) eq uc ($new_item)) {
            return (TRUE);
      }
   }
   return (FALSE);
}


# ------------------------------------------------------------------------------
# Description: Get the default location for Credential Store
# Input: Subroutine style:
#           VICredStore::get_default_path
#        where
#           $dir   - directory to be created.
# Output: Default location of Credential Store
# ------------------------------------------------------------------------------
sub get_default_path
{
   my $filename;
   my $os = get_os ();

   if ('UNIX' eq $os && defined ($ENV{HOME})) {
      $filename = "$ENV{HOME}" . FILE_PATH_UNIX;
   }
   elsif ('WINDOWS' eq $os && defined ($ENV{APPDATA})) {
      $filename = "$ENV{APPDATA}" . FILE_PATH_WIN;
   } else {
      die ERR_OPERATION_FAILED;
   }

   return ($filename);
}


# ------------------------------------------------------------------------------
1;

