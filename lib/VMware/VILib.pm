#
# Copyright 2006 VMware, Inc.  All rights reserved.
#

use 5.006001;
use strict;
use warnings;
use File::Basename;


##################################################################################
package Util;
our $tracelevel = 0;
our $tracefilter;
our $version = '5.1.0';
our $script_version = '5.1.0';


sub trace {
   my ($level, $text) = @_;
   if (($level <= $tracelevel) && (defined $text)) {
      if (defined($tracefilter)) {
         if ($text !~ $tracefilter) {
            print $text;
         }
      } else {
         print $text;
      }
   }
   return;
}

1;
##################################################################################
package Opts;
use Getopt::Long;

our %options = (
   config => {
      type => "=s",
      variable => "VI_CONFIG",
      help => "Location of the VI Perl configuration file",
      func => \&get_default_config,
   },
   protocol => {
      type => "=s",
      variable => "VI_PROTOCOL",
      help => "Protocol used to connect to server",
      default => "https",
   },
   server => {
      type => "=s",
      variable => "VI_SERVER",
      help => "VI server to connect to. Required if url is not present",
      default => "localhost",
   },
   portnumber => {
      type => "=s",
      variable => "VI_PORTNUMBER",
      help => "Port used to connect to server",
   },
   servicepath => {
      type => "=s",
      variable => "VI_SERVICEPATH",
      help => "Service path used to connect to server",
      default => "/sdk/webService"
   },
   url => {
      type => "=s",
      variable => "VI_URL",
      help => "VI SDK URL to connect to. Required if server is not present",
      func => \&get_url,
   },
   # sessionid isn't supported yet because the back-end can't do it             
   #sessionid => {
   #   type => "=s",
   #   variable => "VI_SESSIONID",
   #   help => "Existing session ID/cookie to utilize",
   #},
   credstore => {
      type => "=s",
      variable => "VI_CREDSTORE",
      help => "Name of the credential store file defaults to " .
              "<HOME>/.vmware/credstore/vicredentials.xml on Linux and " .
              "<APPDATA>/VMware/credstore/vicredentials.xml on Windows",
   },
   sessionfile => {
      type => "=s",
      variable => "VI_SESSIONFILE",
      help => "File containing session ID/cookie to utilize",
   },
   savesessionfile => {
      type => "=s",
      variable => "VI_SAVESESSIONFILE",
      help => "File to save session ID/cookie to utilize",
   },   
   username => {
      type => "=s",
      variable => "VI_USERNAME",
      help => "Username",
   },
   password => {
      type => "=s",
      variable => "VI_PASSWORD",
      help => "Password",
   },
   verbose => {
      type => ":s",
      variable => "VI_VERBOSE",
      help => "Display additional debugging information",
   },
   help => {
      type => "",
      help => "Display usage information for the script",
   },
   version => {
      type => "",
      help => "Display version information for the script",
   },
   passthroughauth => {
      type => "",
      variable => "VI_PASSTHROUGHAUTH",
      help => "Attempt to use pass-through authentication",
   },
   passthroughauthpackage => {
      type => "=s",
      variable => "VI_PASSTHROUGHAUTHPACKAGE",
      help => "Pass-through authentication negotiation package",
      default => "Negotiate"
   },
   encoding => {
      type => "=s",
      variable => "VI_ENCODING",
      help => "Encoding: utf8, cp936 (Simplified Chinese), iso-8859-1 (German), shiftjis (Japanese)",
      default => "utf8",
   },
);

our @builtin_options = keys %options;
our @user_options;
our $config_path = undef;
our $app_name = "";
our $enc;

sub add_options {
   my %opts = @_;
   foreach my $key (keys %opts) {
      if (!exists($options{$key})) {
         $options{$key} = $opts{$key};
         push @user_options, $key;
      }
   }
   return;
}

sub get_option {
   my ($key) = @_;
   Util::trace(5, "get_option $key\n");
   my $opt = $options{$key};
   if (!defined($opt)) {
      Util::trace(5, "  => unknown option\n");
      return undef;
   } elsif (defined($opt->{value})) {
      Util::trace(5, "  => value = $opt->{value}\n");
      return (!defined($enc) || Encode::is_utf8($opt->{value})) ? ($opt->{value}) : Encode::decode($enc, $opt->{value});
   } elsif (defined($opt->{func})) {
      my $val = $opt->{func}->();
      Util::trace(5, "  => func = " . (defined($val) ? $val : "<undef>") . "\n");
      return $val;
   } elsif (defined($opt->{default})) {
      Util::trace(5, "  => default = $opt->{default}\n");
      return $opt->{default};
   } else {
      Util::trace(5, "  => <undef>\n");
      return undef;
   }
}

sub set_option {
   my ($key, $value) = @_;
   my $opt = $options{$key};
   if (defined($opt)) {
      $opt->{value} = $value;
   }
   # bug 217030
   else {
      Util::trace(0, "\nWARNING : Not able to set undefined option " . $key . "\n");
   } 
} 

sub option_is_set { 
   my ($key) = @_; 
   Util::trace(5, "option_is_set $key\n");
   my $opt = $options{$key};
   if (!defined($opt)) {
      Util::trace(5, "  => unknown option\n");
      return undef;
   } else {
      Util::trace(5, "  => " . defined($opt->{value}) . "\n");
      return defined($opt->{value});
   }   
}

#
# Construct a url from various inputs
# Priority:
#   first: explicitly specified protocol, server, port, path
#   next: protocol, server, port, path specified in 'url' argument if present;
#      'url' ignored if all of the above are present
#   last: fill in blanks from command line options (including their
#      implicit defaults)
#
sub construct_service_url {
   my %arg = @_;
   use URI;
   my $protocol = delete $arg{protocol};
   my $server = delete $arg{server};
   my $port = delete $arg{port};
   my $path = delete $arg{servicepath};
   my $url_in = delete $arg{url};

   use Carp;
   croak "Unknown arg(s) " . join(', ', sort keys %arg) . " to 'Opts::construct_url'"
      if keys %arg;

   #
   # Explicitly provided components take precedence over stuff
   # supplied in the URL
   #
   unless (defined $protocol and defined $server and
           defined $port and defined $path) {
      if ($url_in) {
          my $uri = URI->new($url_in);
          $protocol ||= $uri->scheme;
          $server ||= $uri->host;
          $port ||= $uri->port;
          $path ||= $uri->path;
      }
   }
   $protocol ||= get_option('protocol');
   $server ||= get_option('server');
   $port ||= get_option('portnumber');
   $path ||= get_option('servicepath');
   my $url_out = URI->new;
   $url_out->scheme($protocol);
   $url_out->host($server);
   $url_out->path($path);
   $url_out->port($port);

   return $url_out->as_string;
}

sub get_url {
   my $protocol = get_option('protocol');
   my $server = get_option('server');
   my $port = get_option('portnumber');
   $port = defined($port) ? ":$port" : "";
   my $path = get_option('servicepath');
   return "${protocol}://${server}${port}${path}";
}

sub get_default_config {
  # XXX Needs more work for non linux platforms...
   if ($^O =~ /MSWin32/) {
      my $home = $ENV{HOME} || $ENV{LOGDIR} || return undef;
      return $home . "/visdk.rc";
   } else {
      my $home = $ENV{HOME} || $ENV{LOGDIR} || (getpwuid($<))[7] || return undef;
      return $home . "/.visdkrc";
   }
}

sub print_option {
   my ($key) = @_;
   my $opt = $options{$key};
   my $var = $opt->{variable};
   my $default = $opt->{default};
   my $required = $opt->{required};

   # XXX align columns
   # bug 387249
   print "   --$key";
   my @info = ();
   if ($required) {
      push @info, "required";
   }
   if (defined($var)) {
      push @info, "variable $var";
   }
   if (defined($default)) {
      push @info, "default '$default'";
   }
   if (@info) {
      print " (" . join(", ", @info) . ")";
   }
   print "\n";
   if (defined($opt->{alias})) {
      my @aliases = split(/\|/, $opt->{alias});
      foreach my $alias (@aliases) {
         print "    -$alias\n";
      }
   }
   print "      $opt->{help}\n";
   return;
}

sub usage {
   print "\n";

   my $default_str = "";
   
   if (defined($options{_default_})) {
      my $default = $options{_default_};
      $default_str = defined($default->{argval}) ? $default->{argval} : "argval";
      if (defined($default->{required}) && $default->{required}) {
         $default_str = "<$default_str>";
      } else {
         $default_str = "[<$default_str>]";
      }
   }
   
   print "Synopsis: " . $app_name . " OPTIONS " .  $default_str;
   print "\n\n";

   if (@user_options) {
      print "\n";
      print "Command-specific options:\n";
      foreach my $key (sort @user_options) {
         print_option($key) unless $key eq "_default_";
      }
   }
   
   print "\nCommon VI options: \n";
   foreach my $key (sort @builtin_options) {
      print_option($key);
   }   
}

sub parse_cmdline {
   my %vals;
   my ($pass_through_option) = @_;

   my @spec = 
      map { (defined($options{$_}{alias}) ? "$_|$options{$_}{alias}" : $_) . 
            (defined($options{$_}{type}) ? "$options{$_}{type}" : '=s') } keys %options;
   Getopt::Long::Configure('no_ignore_case', $pass_through_option, 'no_auto_abbrev');
   if (!GetOptions(\%vals, @spec)) {
      # bug 271033
      $app_name = $0;  
      # bug 290470
      die "For a summary of command usage, type '$0 --help'. \n" .
          "For documentation, type 'perldoc $0'.\n";
   }
   # bug 165965
   if(exists $vals{'verbose'}) {
      my $opt = $options{'verbose'};
      if (!defined($opt->{value})) {
         $opt->{value} = $vals{'verbose'};
         if ($vals{'verbose'} =~ /^\d+$/) {
            $Util::tracelevel = $vals{'verbose'};
         } else {
            $Util::tracelevel = 3;
            if ($vals{'verbose'} ne "") {
               $Util::tracefilter = $vals{'verbose'};
            }
         }
      }
   }

   Util::trace(5, "parse_cmdline\n");
   foreach my $key (keys %vals) {
      if($key ne 'verbose') {
         my $opt = $options{$key};
         Util::trace(5, "  => $key = $vals{$key}\n");
         if (!defined($opt->{value})) {
            $opt->{value} = $vals{$key};
         } else {
            Util::trace(5, "     $key already set to $opt->{value}\n");
         }
      }
   }

   # Final default "flagless" argument handling if applies.
   if (defined($options{_default_}) && $#ARGV == 0) {
      $options{_default_}->{value} = shift(@ARGV);
   }
   return;
}

sub parse_environment {
   Util::trace(5, "parse_environment\n");
   foreach my $opt (values %options) {
      if (defined($opt->{variable}) && !defined($opt->{value})) {
         if (defined($ENV{$opt->{variable}})) {
            Util::trace(5, "  => $opt->{variable} = $ENV{$opt->{variable}}\n");
            $opt->{value} = $ENV{$opt->{variable}};
         }
      }
   }
   return;
}

# bug 217294
sub validate_options{
   my ($var, $val) = @_;
   foreach my $opt (values %options) {
         if (defined($opt->{variable}) && ($var eq $opt->{variable})){
           return '1';
         }
   }
}

sub parse_config {
   my $cfgfile = get_option('config');
   return if (!defined($cfgfile));
   Util::trace(5, "parse_config $cfgfile\n");
   local *CFGFILE;

   # bug 216803 
   if(open(IN,$cfgfile)) {
      if(eof(IN)){
          print "\nWarning : The file exists but is empty.\n";
          return;
       }
    }
    my $read_flag = open(CFGFILE, $cfgfile); 
    if(defined $read_flag && $read_flag == 1) {
       $config_path = $cfgfile;
    }
    if (option_is_set('config')) {
       if((!defined $read_flag)) {
          print "\nWarning: Unable to open file '".$cfgfile."'.\n";
          $config_path = undef;
          return;
       }
    }
    else {
       if((!defined $read_flag)) {
          $config_path = undef;
          return;
       }
    }

   Util::trace(5, "file opened; reading...\n");
   while (<CFGFILE>) {
      chomp;
      my ($var, $val) = split(/\s*=\s*/, $_, 2);
      # bug 217294
      # bug 216803
      if(defined $var) {
         my $warn; 
         $warn = validate_options($var,$val);
         if(!$warn eq '1') {
            Util::trace(5, "Warning: Undefined variable '$var' in config file.\n");
         }
         elsif((!defined $val)) {
            Util::trace(5, "Warning: No value is defined for '$var'.\n");
         }
      }
      next if !defined($var);
      foreach my $opt (values %options) {
         if (defined($opt->{variable}) && ($var eq $opt->{variable})) {
            if(defined $val){
               Util::trace(5, "  => $var = $val\n");
            }
            if (!defined($opt->{value})) {
               $opt->{value} = $val;
            } else {
               Util::trace(5, "  $var already set to $opt->{value}\n");
            }
            last;
         }
      }
   }

   Util::trace(5, "...done\n");
   close(CFGFILE);
   return;
}

# bug 217418
sub config_path {
   return $config_path;
}

sub parse_stdin {
   return;
}

sub getencname() {
   my $cp;
   my $encname = "utf8";

   if ($^O =~ /Win32/i) {
      # get Windows codepage
      if (open(IN, "chcp |")) {
         while (<IN>) {
            if ($_ =~ /[^0-9]*([0-9]{3,4})/) { # Code Page is 3 or 4 digits number
               $cp = $1;
               last;
            }
         }
         close(IN);

         if (defined $cp) {
            if ($cp eq "936") {
               $encname = "cp936";
            } elsif ($cp eq "850") {
               $encname = "iso-8859-1";
            } elsif ($cp eq "932") {
               $encname = "shiftjis";
            }
         }
      }
   }

   return $encname;
}

sub parse {
   my ($pass_through_option) = @_;
   if (!defined($pass_through_option)) {
      $pass_through_option = 'no_pass_through';
   }
   parse_cmdline($pass_through_option);
   
   # bug 182644
   $app_name = $0;
   $0 = "Hiding the command line arguments";
   
   parse_environment;
   parse_config;
   parse_stdin;
   
   # user overwrites system encoding
   $enc = get_option('encoding');
   if ($enc eq "utf8") {
      $enc = getencname();
   }
   
   if (defined($enc)) {
      binmode(STDIN, ":encoding($enc)");
      binmode(STDOUT, ":encoding($enc)");
      binmode(STDERR, ":encoding($enc)");
   }
   return;
}

sub validate {
   my @validators = @_;
   if (option_is_set('help')) {
      usage();
      exit 0;
   }
   if (option_is_set('version')) {
      if (defined($VMware::VIRuntime::VERSION)) {
         print "vSphere SDK for Perl version: $VMware::VIRuntime::VERSION\n";
      } else {
         print "vSphere SDK for Perl version: $Util::version\n";
      }
      if (defined($Util::script_version)) {
         my $basename = File::Basename::basename($app_name);
         print "Script '$basename' version: $Util::script_version\n";
      }
      exit 0;
   }
   my $valid = 1;
   
   # bug 222613
   foreach my $validator (@validators) {
       if (!&$validator()) {
          $valid = 0;
       }
   }
   if (!$valid) {
      usage();
      exit 1;
   }
   
   foreach my $key (sort @builtin_options) {
      my $opt = $options{$key};
      if (defined($opt->{required}) && $opt->{required} && !option_is_set($key)) {
         print "Required VI option '$key' not specified.\n";
         $valid = 0;
      }
   }
   foreach my $key (sort @user_options) {
      my $opt = $options{$key};
      if (defined($opt->{required}) && $opt->{required} && !option_is_set($key)) {
         print "Required command option '$key' not specified.\n";
         $valid = 0;
      }
   }
   
   # bug 268260
   if (!(option_is_set('help') || option_is_set('version') ||
         option_is_set('passthroughauth')) && $valid) {
      my $flag = "false";
      if (-t STDIN) {
         $flag = "true";
      }

      # bug 361529
      my $askPwd = 0;
      if (defined $ENV{'VI_USERNAME'}) {
         $askPwd = (get_option('username') ne $ENV{'VI_USERNAME'}) ? 1 : 0;
         # bug 425681
         if (defined(get_option('password'))) {
            $askPwd = 0;
         }
      }

      if ((!option_is_set('username') || !option_is_set('password') || 1 == $askPwd) && !option_is_set('sessionfile')) {
         # First Check It In The Credential Store Library
         # bug 374359
         my $servername;
         if (option_is_set('url')) {
            my $url = get_option('url');
            if ($url =~ s|http(s?)://(.*)/sdk.*|http$1://$2/sdk/vimService.wsdl|i) {
               $servername = $2;
            }
         }
         else {
            $servername = get_option('server');
         }
         # bug 316125
         my $filename = get_option('credstore');
         if(not defined $filename){
            require VMware::VICredStore;
            $filename = VMware::VICredStore::get_default_path();
            if (not -e $filename) {
               $filename = undef;
            }
            else {
               local *CREDSTOREFILE;
               my $read_flag = open(CREDSTOREFILE, $filename); 
               if ( not (defined $read_flag && $read_flag == 1) ) {
                  warn "Note: Default credential store file is not readable.\n";
                  $filename = undef
               }
            }
         }
         # bug 314396
         if (defined($filename) ) {
            # bug 316125
            local *CREDSTOREFILE_EXIST;
            my $read_flag_exist = open(CREDSTOREFILE_EXIST, $filename); 
            if (not -e $filename) {
               warn "Note: credential store file '$filename' does not exist \n";
            }
            elsif ( not (defined $read_flag_exist && $read_flag_exist == 1) ) {
               warn "Note: credential store file '$filename' is not readable.\n";
            }
            else {
               require VMware::VICredStore;
               eval {
                  VMware::VICredStore::init(filename => $filename);
                  if (!defined get_option('username')) {
                     my @user_list = VMware::VICredStore::get_usernames(server => $servername);
                     if(@user_list eq '1') {
                        Opts::set_option('username' => $user_list[0]);
                     }
                     else {
                        # when more then one users
                        print "Enter username: ";
                        my $username = <STDIN>;
                        chomp $username;
                        $options{username}{value} = $username;
                     }
                  }
                  my $pwd = VMware::VICredStore::get_password (server => $servername, 
                                                               username => get_option('username'));
                  if (defined $pwd) {
                     $options{password}{value} = $pwd;
                  }
               };
               if ($@) { 
                  Util::trace(0, "Error ::  ". $@ . "" );
               }
               VMware::VICredStore::close();
            }
         }
         # bug 351567
         if(!option_is_set('username')) {
            print "Enter username: ";
            my $username = <STDIN>;
            chomp $username;
            $options{username}{value} = $username;
         }

         if(!option_is_set('password') || 1 == $askPwd ) {
            print "Enter password: ";
            if ( $^O eq "MSWin32" ) {
               require Term::ReadKey;
               Term::ReadKey->import(qw(ReadMode));
               Term::ReadKey->import(qw(ReadLine));
               ReadMode('noecho');
               chomp(my $password = ReadLine(0));
               ReadMode('normal');
               $options{password}{value} = $password;
            }
            else {
               system("stty -echo") and die "ERROR: stty failed\n";
               chomp (my $password = <STDIN>);
               system("stty echo") and die "ERROR: stty failed\n";
               $options{password}{value} = $password;
            }
            print "\n";
         }
      }
   }
   
   # one of sessionfile or (username, password) must be present. if not print usage
   if ($valid && !option_is_set('sessionfile') && 
       !(option_is_set('username') && option_is_set('password')) &&
       !(option_is_set('passthroughauth'))) {
      print "Must have one of command options 'sessionfile', 'passthroughauth', 'credstore' or " .
            "a 'username' and 'password' pair\n";
      $valid = 0;
   }

   if (!$valid) {
      usage();
      exit 1;
   }
   return;
}

sub assert_usage {
   my ($cond, $string) = @_;
   unless ($cond) {
      print STDERR "$string\n";
      # bug 445565
      # usage();
      print STDERR "For a summary of command usage, type '$app_name --help'.\n" .
                   "For documentation, type 'perldoc $app_name'.\n";      
      exit 1;
   }
   return;
}

1;
##################################################################################
__END__

## bug 480897

=head1 NAME

=item B<VILib.pm>

=head1 HELP-LINKS

See the vSphere SDK for Perl Programming Guide at http://www.vmware.com/support/developer/viperltoolkit/ for reference documentation for the subroutines.


