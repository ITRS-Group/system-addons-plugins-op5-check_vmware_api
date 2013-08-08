
#
# Copyright 2006 VMware, Inc.  All rights reserved.
#

use 5.006001;
use strict;
use warnings;

use Carp qw(confess croak);
use XML::LibXML;
use LWP::UserAgent;
use LWP::ConnCache;
use HTTP::Request;
use HTTP::Headers;
use HTTP::Response;
use HTTP::Cookies;
use Data::Dumper;


##################################################################################
package Util;

our $is_connected = 0;

sub check_fault {
   my $result = shift;
   if ($result->fault) {
      Carp::confess($result->fault);
   }   
   return $result->result;
}

# Displays error and exit.
#
sub fail {
   # bug 461963
   $! = 1;
   die "@_\n";
}

# --------------------------------------------------------------------------------
# Description: Establish a connection to the vCenter or ESX server.
# Input: subroutine style:  Util::connect($url, $username, $password})
#        where
#           $url      - the URL of the server to which the client connects
#           $username - user account on the VC or ESX server
#           $password - password for the user account
# Output: a Vim object instance
# --------------------------------------------------------------------------------
sub connect {
   # url should be <protocol>://<hostname>/sdk
   my ($url, $username, $password) = @_;
   
   # bug 217340
   @_ = ();
   my $retval = undef;
   
   if (!defined($url)) {
      $url = Opts::get_option('url');
   }
   
   if (Opts::option_is_set('sessionfile')) {
      my $sessionfile = Opts::get_option('sessionfile');
      $retval = Vim::load_session(service_url => $url, session_file => $sessionfile);
   } elsif ((Opts::option_is_set('username') || defined($username)) && (Opts::option_is_set('password') || defined($password))) {
      if (!defined($username)) {
         $username = Opts::get_option('username');
      }
      
      if (!defined($password)) {
         $password = Opts::get_option('password');
      }
      
      eval {
         $retval = Vim::login(service_url => $url, user_name => $username, password => $password);
      };
      if ($@) {
         my $error = "Error connecting to server at '$url'";
         if ($@ =~ /Connection refused/) {
            Util::fail("$error: Connection refused");
         } elsif ($@ =~ /Bad hostname/) {
            Util::fail("$error: Bad hostname");
         } elsif ($@ =~ /Connect failed/) {
            Util::fail("$error: Perhaps host is not a vCenter or ESX server");
         } elsif ($@ =~ /Login failed/) { 
            Util::fail("$error: Login failed due to a bad username or password");
         } elsif (ref $@ eq "SoapFault" && defined $@->{fault_string}) {
            Util::fail("$error: " . $@->{fault_string});
         } else {
            Util::fail("$@");
         }
      }
   } elsif (Opts::option_is_set('passthroughauth')) {
      if ($^O =~ /MSWin32/) {
         eval {
            require Win32::OLE;
         };
         if ($@) {
            Util::fail("Cannot load Win32::OLE: $@");
         }
         my $sspi = Win32::OLE->new("SSPICOM.SspiClientSession");
         if (!defined($sspi)) {
            Util::fail("Error: can not create SSPI session.");
         }
         my $package = Opts::get_option("passthroughauthpackage");
         if (!$sspi->Begin($package) || $sspi->GetState() ne "Negotiating") {
            Util::fail("Error: SSPI Begin failed: package '$package'");
         }
         my $done = 0;
         while (!$done) {
            my $token = $sspi->GetToken();
            eval {
               $retval = Vim::login_by_sspi(service_url => $url, token => $token);
            };
            if ($@) {
               my $fault = $@;
               if (ref $fault eq "SoapFault" && defined $fault->{detail} &&
                  ref $fault->{detail} eq "SSPIChallenge") {
                  my $serverToken = $fault->{detail}->{base64Token};
                  if (!$sspi->Initialize($serverToken) ||
                     $sspi->GetState() eq "Error") {
                     Util::fail("Error: SSPI Initialize failed.");
                  }
               } else {
                  $done = 1;
                  my $error = "Error connecting to server at '$url'";
                  Util::fail("$error: $@");
               }
            } else {
               $done = 1;
            }
         }
         $sspi->Reset();
      }
      else {
         eval {
            require GSSAPI;
            require GSSAPI::Status;
            require MIME::Base64;
         };
         if ($@) {
            Util::fail("Error: can not load required modules for SSPI $@");
         }
         my $gss_output_token = "";
         my $out_flags = "";
         my $out_time = "";
         my $retval = undef;
         my $gss_server_name = "";
         my $status = "";
         my $gss_auth_flags = 0;
         my $gss_input_token = q{};
         my $client_context;
         my $error = 0;
         if ($url =~ s|http(s?)://(.*)/sdk.*|http$1://$2/sdk/vimService.wsdl|i) {
            my $url = URI->new($url);
            my $server_name = $url->host();
            $server_name = "host\@".$server_name;
            $status = GSSAPI::Name->import($gss_server_name,
                                           $server_name,
                                           GSSAPI::OID::gss_nt_service_name());
            {  #just scope
               $status = GSSAPI::Context::init($client_context,
                                               GSSAPI::GSS_C_NO_CREDENTIAL(),
                                               $gss_server_name,
                                               GSSAPI::GSS_C_NO_OID(),
                                               $gss_auth_flags,
                                               0,
                                               GSSAPI::GSS_C_NO_CHANNEL_BINDINGS(),
                                               $gss_input_token,
                                               undef,
                                               $gss_output_token,
                                               $out_flags,
                                               $out_time);
               if($status->major != GSSAPI::GSS_S_COMPLETE()) {
                  my @major_errors = $status->generic_message();
                  my @minor_errors = $status->specific_message();
                  foreach my $s (@major_errors) {
                     print STDERR "  MAJOR ERROR ::$s\n";
                  }
                  foreach my $s (@minor_errors) {
                     print STDERR "  MINOR ERROR ::$s\n";
                  }
                  Util::fail("Error: Unable to initialize client security context.");
               }
            }
            my $token = MIME::Base64::encode_base64($gss_output_token);
            eval {
               $retval = Vim::login_by_sspi(service_url => $url, token => $token);
            };
            if ($@) {
               my $error = "Error connecting to server at '$url'";
               Util::fail("$error: $@");
            }
         }
         else {
            Util::fail("Invalid URL '$url'");
         }
      }
   } else {
      Util::fail("Error: No session file or username/password provided.");
   }   
   $is_connected = 1;
   return $retval;
}

# --------------------------------------------------------------------------------
# Description: Disconnect a session with the vCenter or ESX server.
# Input: none
# Output: none
# --------------------------------------------------------------------------------
sub disconnect {
   Vim::get_vim()->disconnect if Vim::get_vim();
   return;
}

sub create_entity_info {
   my $objectContent = shift;
   my $propSet = $objectContent->propSet;
   my $name;
   my $parent;
   foreach (@$propSet) {
      if ($_->name eq "name") {
         $name = $_->val;
      } elsif ($_->name eq "parent") {
         $parent = $_->val;
      }
   }
   return { name => $name, parent => $parent };
}

# --------------------------------------------------------------------------------
# Description: Return the inventory path for the specified managed entity.  
# Input: subroutine style:  Util::get_inventory_path($entity, $vim})
#        where
#           $entity   - a managed entity view
#           $vim      - a Vim object instance
# Output: a string that identifies the inventory path of the managed entity.
# --------------------------------------------------------------------------------
sub get_inventory_path {
   # bug 193817
   my ($entity, $service) = @_;
   my $propertyCollector = $service->{service_content}->propertyCollector;

   # Retrieve the "name" and "parent" properties for all the managed entities
   # reachable by following "parent" properties starting from $entity.
   my $objectContents = Util::check_fault(
      $service->{vim_service}->RetrieveProperties(
      _this => $propertyCollector,
       specSet => [
        PropertyFilterSpec->new(
            propSet => [
          PropertySpec->new(
             type => "ManagedEntity",
             pathSet => [ "name", "parent" ]
          )
          ],
           objectSet => [
           ObjectSpec->new(
            obj => $entity->{mo_ref},
             selectSet => [
             TraversalSpec->new(
                name => "ParentTraversalSpec",
               type => "ManagedEntity",
               path => "parent",
               selectSet => [
                  SelectionSpec->new(name => "ParentTraversalSpec") 
               ]
            )
             ]
          )
           ]
        )
     ]
      )
   );

   # Create a hash containing an entry for each manaaged entity retrieved by
   # the RetrieveProperties call above.
   my %entityMap;
   foreach (@$objectContents) {
      my $objectContent = $_;
      if (defined $objectContent->missingSet) {
         die $objectContent->missingSet . "\n";         
      }
      $entityMap{$objectContent->obj->value} = create_entity_info($objectContent);
   }

   # Use entityMap to walk the "parent" properties of the managed entities,
   # starting with managedEntity, computing the inventory path (from end to
   # beginning) along the way.
   my $current = $entityMap{$entity->{mo_ref}->value};
   my $parent = $current->{parent};
   if (! defined $parent) {
      return "";
   }
   my @path;
   while (1) {
      unshift(@path, $current->{name});
      $current = $entityMap{$parent->value};
      $parent = $current->{parent};
      if (! defined $parent) {
	 last;
      }
   }
   return join "/", @path
}

1;
##################################################################################


##################################################################################
package Vim;

use Data::Dumper;
use URI::Escape;
use Carp;

#
# Hash of (potentially) open connections, in the format
#     ( $vim_obj1 => $vim_obj1, $vim_obj2 = $vim_obj2, ...)
#     The key is the stringified version of the object reference, which
#     is unique per reference but NOT the actual reference
#
our %vim_connection = ();

our $vim_global = undef;
our $server_version = undef;
our $vim_namespace = undef;
our $SESSION_STATUS_OK = 1;

#
# This hack stores the filename under which the global session has
# most recently been saved. It is used to avoid saving the global
# session twice in the case where the 'savesessionfile' command line
# option is set and the user has *explicitly* done a save session on
# the global session. In this case the global session is no longer
# saved on disconnect, in particular, the default disconnect at
# program termination.
#
our $global_vim_saved_to_file = undef;

sub get_server_version { $server_version };
sub get_vim_namespace { $vim_namespace };

sub set_server_version { 
   my ($arg) = @_; 
   $server_version = $arg;
}

sub new {
   my ($class, %args) = @_;
   my $self = bless {}, $class;

   my $server = delete($args{server});
   my $protocol = delete($args{protocol});
   my $path = delete($args{path});
   my $port = delete($args{port});
   my $url = delete($args{service_url});

   if (keys %args) {
      croak "Unrecognized arg(s) " . 
            join(', ', sort keys %args) . " to 'Vim::new'";
   }

   $url = Opts::construct_service_url(
      server => $server,
      protocol => $protocol,
      servicepath => $path,
      port => $port,
      url => $url,
   );

   $self->{service_url} = $url;
   $self->{service_content} = undef;
   $self->{vim_service} = undef;

   $self->set_logout_on_disconnect;
   return $self;
}


#
# _select_vim - internal subroutine to distinguish between Vim::xxx and
# $vim->xxx call syntax, and return the appropriate Vim object. Place 
# at the top of sub xxx like:
#    sub xxx {
#       my $self = &_select_vim;   # <-- this EXACT syntax, w/ & and w/o ()
#    }
# This will test to see if there is a first argument of Vim type, in which
# case it will be shifted off @_ and returned. If there is no argument or
# the first argument is not a Vim object, then the global Vim object will
# be returned, or if there is no global Vim, an exception will be thrown.
#
# If it isn't desired to throw an exception for a missing global Vim, 
# use this instead:
#   my $self = ref($_[0] eq 'Vim') ? shift : $vim_global;
#
sub _select_vim {
   my $self;
   if (ref($_[0]) eq 'Vim') {
      $self = shift;
   } else {
      Carp::croak((caller 1)[3] . " called, but no global session is defined")
         unless $vim_global;
      $self = $vim_global;
   }
   return $self;
}

# bug 231138
# --------------------------------------------------------------------------------
# Description: Return the current Vim object instance.
# Input:  none
# Output: $self       if called as vim->get_vim() 
#         $vim_global if called as Vim::get_vim()
# --------------------------------------------------------------------------------
sub get_vim {
   return ref($_[0]) eq 'Vim' ? $_[0] : $vim_global;
}

sub query_api_supported {
   my $url = shift;
   my %supportedapiversions;
   if ($url =~ s|http(s?)://(.*)/sdk.*|http$1://$2/sdk/vimService.wsdl|i) {      
      if ($1 eq "s") {
         eval {  
            require Crypt::SSLeay;  
            Crypt::SSLeay->import();
         };
         if ($@) {
            die "Crypt::SSLeay is required for https connections, but could not be loaded: $@";
         }
      }

      my $temp_addr = $2;
      if ($temp_addr =~ /:/) {
         if (($temp_addr =~ tr/:/:/) > 1) {
            die "Unsupported IP address format\n";
         }
      }

      my $xmlurl = substr $url, 0, index($url, '/sdk');
      $xmlurl = $xmlurl . '/sdk/vimServiceVersions.xml';

      my $user_agent = LWP::UserAgent->new(agent => "VI Perl");
      my $cookie_jar = HTTP::Cookies->new(ignore_discard => 1);
      $user_agent->cookie_jar($cookie_jar);
      $user_agent->protocols_allowed(['http', 'https']);
  
      my $http_header = HTTP::Headers->new(Content_Type => 'text/xml');
      my $request = HTTP::Request->new('GET', $xmlurl);
      my $response = $user_agent->request($request);   
     
      if ($response->content =~ /Connection refused/) {
         die $response->content . "\n";
      } elsif ($response->content =~ /Bad hostname/) {
         die $response->content . "\n";
      } elsif ($response->content =~ /Connect failed/) {
         die $response->content . "\n";
      }
      my $xml_parser = XML::LibXML->new;
      my $result;
      if ($response->status_line eq '404 Not Found') {
         # server prior to VC 4.0 and ESX 4.0
         $supportedapiversions{"supported"} = 0;
         return %supportedapiversions;
      }
      else {
         eval { $result = $xml_parser->parse_string($response->content) };
         if ($@) {
            die "vimServiceVersions.xml version unavailable at '$xmlurl'\n";
            $supportedapiversions{"supported"} = 0;
            return %supportedapiversions;
         }
         $supportedapiversions{"supported"} = 1;
         my @body = $result->documentElement()->getChildrenByTagName('namespace');
         foreach my $ns (@body) {
            my $name = $ns->getChildrenByTagName("name")->shift;
            if ($name->textContent eq "urn:vim25") {
               my $version = $ns->getChildrenByTagName("version")->shift;
               $supportedapiversions{"version"} = $version->textContent;
               my $priorversion = $ns->getChildrenByTagName("priorVersions")->shift;
               my @priorversions = $priorversion->getChildrenByTagName("version");
               my @pversion;
               foreach my $pv (@priorversions) {
                  push(@pversion, $pv->textContent);
               }
               $supportedapiversions{"priorversions"} = \@pversion;
               last;
            }
         }
         return %supportedapiversions;
      }
   } else {
      die "Invalid URL '$url'\n";
   }
}

sub query_server_version {
   my $url = shift;
   if ($url =~ s|http(s?)://(.*)/sdk.*|http$1://$2/sdk/vimService.wsdl|i) {
      # bug 288336
      if ($1 eq "s") {
         eval {  
            require Crypt::SSLeay;  
            Crypt::SSLeay->import();
         };
         if ($@) { 
            die "Crypt::SSLeay is required for https connections, but could not be loaded: $@";
         }
      }
      # no IPv6 support yet
      my $temp_addr = $2;
      if ($temp_addr =~ /:/) {
         if (($temp_addr =~ tr/:/:/) > 1) {
            die "Unsupported IP address format\n";
         }
      }
      my $user_agent = LWP::UserAgent->new(agent => "VI Perl");
      my $cookie_jar = HTTP::Cookies->new(ignore_discard => 1);
      $user_agent->cookie_jar($cookie_jar);
      $user_agent->protocols_allowed(['http', 'https']);
  
      my $http_header = HTTP::Headers->new(Content_Type => 'text/xml');
      my $request = HTTP::Request->new('GET', $url);
     
      my $response = $user_agent->request($request);   
     
      if ($response->content =~ /Connection refused/) {
         die $response->content . "\n";
      } elsif ($response->content =~ /Bad hostname/) {
         die $response->content . "\n";
      } elsif ($response->content =~ /Connect failed/) {
         die $response->content . "\n";
      }
      
      my $xml_parser = XML::LibXML->new;   
      my $result;   

      eval { $result = $xml_parser->parse_string($response->content) };
      if ($@) {
         die "Server version unavailable at '$url'";
      }   
   
      my $targetNamespace = $result->documentElement()->getAttribute('targetNamespace');
      
      if (!defined($targetNamespace)) {
         # bug 462362
         $targetNamespace = "";
      }
      
      my ($server_version) = $targetNamespace =~ 
                            /(?:urn:vim)([0-9a-zA-Z]+)(?:Service)/;
                      
      if ($server_version) {
         return $server_version;
      } else {
         die "Server version '$targetNamespace' at '$url' unsupported.\n";
      }
   } else {
      die "Invalid URL '$url'\n";
   }
   return $server_version;
}

# --------------------------------------------------------------------------------
# Description: Establish a session with the vCenter or ESX server.
# Input: subroutine style:  Vim::login(%{service_url, user_name, password})
#        method call style: vim->login(%{user_name, password})
#        where
#           service_url - the URL of the server to which the client connects
#           user_name   - user account on the VC or ESX server
#           password    - password for the user account
# Output: a Vim object instance
# --------------------------------------------------------------------------------
sub login {
   my $self;
   my $using_vim_global = 0;
   if (ref($_[0]) eq 'Vim') {
      $self = shift;
   } else {
      $using_vim_global = 1;
   }
   my %args = @_;
   # bug 217340
   @_ = ();
   # bug 298064

   # Allow 'username' as a synonym for 'user_name'
   if (not defined $args{user_name} and defined $args{username}) {
      $args{user_name} = delete $args{username};
   }

   if ($using_vim_global) {
      my $service_url = delete $args{service_url};
      Carp::croak("The required service_url argument to login() is missing or undefined.")
         unless defined $service_url;
      $self = Vim->new(service_url => $service_url);      
   }

   my $username = delete $args{user_name};
   my $password = delete $args{password};

   unless (defined $username) {
      Util::fail("Error: The required user_name parameter to login() is missing or undefined.");
   }
   unless (defined $password) {
      Util::fail("Error: The required password parameter to login() is missing or undefined.");
   }

   my $service_url = $self->{service_url};

   if (keys %args) {
      croak "Unrecognized arg(s) " . 
            join(', ', sort keys %args) . " to 'Vim::login'";
   }

   #
   # Load the appropriate Runtime/Stubs if not done yet, and
   # set the default namespace.
   #
   unless ($server_version) {
      $server_version = query_server_version($service_url);
   }
      
   unless ($vim_namespace) {
      $vim_namespace = "vim$server_version";
      eval qq(require VMware::VIMRuntime);
      die "$@\n" if $@;
      VIMRuntime->initialize($server_version);
   }
      
   my $si_mo_ref = ManagedObjectReference->new(type => 'ServiceInstance',
                                               value => 'ServiceInstance');
   $self->{vim_service} = VimService->new($service_url);
   my $sc = Util::check_fault(
      $self->{vim_service}->RetrieveServiceContent(_this => $si_mo_ref)
   );
   my $result = $self->{vim_service}->Login(_this => $sc->sessionManager,
                                            userName => $username,
                                            password => $password);
   if ($result->fault) {
      die "Error: " . $result->fault->{fault_string} . "\n";
   }
   $self->{service_content} = $sc;
   $vim_connection{$self} = $self;

   $vim_global = $self if $using_vim_global;
   return $self;
}

# ----------------------------------------------------------------------------------
# Description: Establish a session with the vCenter or ESX server using SSPI.
# Input: subroutine style:  Vim::login_by_sspi(%{service_url, token})
#        method call style: vim->login_by_sspi(%{token})
#        where
#           service_url - the URL of the server to which the client connects
#           token       - the SSPI token
# Output: a Vim object instance
# ----------------------------------------------------------------------------------
sub login_by_sspi {
   my ($first_arg) = @_;
   if ($first_arg && ref $first_arg eq 'Vim') {
      # object reference 
      my ($self, %args) = @_;
      my $service_url = $self->{service_url};
      my $token = $args{token};
      
      #
      # Load the appropriate Runtime/Stubs if not done yet, and
      # set the default namespace.
      #
      unless ($server_version) {
         $server_version = query_server_version($service_url);
      }
      
      unless ($vim_namespace) {
         $vim_namespace = "vim$server_version";
         eval qq(require VMware::VIMRuntime);
         die "$@\n" if $@;
         VIMRuntime->initialize($server_version);
      }
      
      if (!defined $self->{vim_service}) {           
         my $si_moref = ManagedObjectReference->new(type => 'ServiceInstance',
                                                    value => 'ServiceInstance');
         $self->{vim_service} = VimService->new($service_url);
         my $sc = Util::check_fault($self->{vim_service}->RetrieveServiceContent(_this => $si_moref));
         $self->{service_content} = $sc;
      }
      Util::check_fault($self->{vim_service}->LoginBySSPI(
                  _this => $self->{service_content}->sessionManager,
                  base64Token => $token));
   } else {
      my %args = @_;
      if (!defined($vim_global)) {
         my $service_url = $args{service_url};
         $vim_global = Vim->new(service_url => $service_url);
      }      
      my $token = $args{token};
      $vim_global->login_by_sspi(token => $token);
   }
   $vim_connection{$vim_global} = $vim_global;
   return $vim_global;
}

sub disconnect {
   my $self = ref($_[0] eq 'Vim') ? shift : $vim_global;
   if ($self) {
      #
      # Disconnect called on an already disconnected/cleared session?
      # Do a clear again in case we somehow got here with an inconsistent 
      # state, then return.
      #
      unless ($self->{vim_service}) {
         $self->clear_session;
         return;
      }
      if ($vim_global and $self eq $vim_global) {
         #
         # When disconnecting the global session, check for the
         # 'savesessionfile' option and save the session if appropriate.
         # We do this without any checks *here* to see if the session is
         # still logged in, etc., although save_session() itself
         # should be checking to see that it's saving a session that
         # is still logged in.
         #
         if (Opts::option_is_set('savesessionfile')) {
            my $file = Opts::get_option('savesessionfile');
            if (not defined($global_vim_saved_to_file) or
                (defined $global_vim_saved_to_file and
                 $global_vim_saved_to_file ne $file)) {
               $self->save_session(session_file => $file);
               $global_vim_saved_to_file = $file;
            }
         }
      }
      if ($self->is_logout_on_disconnect) {
         $self->logout;
      } else {
         $self->clear_session;
      }
   }
}

# --------------------------------------------------------------------------------
# Description: Retrieve the session id corresponding to the current session.
# Input:  none
# Output: a session id for use by load_session()
# --------------------------------------------------------------------------------
sub get_session_id {
   my $self = &_select_vim;
   return $self->{vim_service}->get_session_id;
}

# --------------------------------------------------------------------------------
# Description: Save a session cookie to a specified file.
# Input: subroutine style:  Vim::save_session(%{session_file})
#        method call style: vim->save_session(%{session_file})
#        where
#           session_file - full path file name where session is saved to
# Output: none
# --------------------------------------------------------------------------------
sub save_session {
   my $self = &_select_vim;
   my %args = @_;
   if (!defined($args{session_file})) {
      Carp::croak("Missing session_file parameter\n");
   }
   unless ($self->get_session_status eq $SESSION_STATUS_OK) {
      warn "Warning: The session being saved to '$args{session_file}' is expired or not authenticated.\n";
   }
   $self->{vim_service}->save_session($args{session_file});
   #
   # Bookkeeping needed to make --savesessionfile work precisely right.
   #
   if ($vim_global and $self eq $vim_global) {
      $global_vim_saved_to_file = $args{session_file};
   }
   $self->unset_logout_on_disconnect;
   return;
}

# bug 264430

# --------------------------------------------------------------------------------
# Description: Get the status of session.
# Input: subroutine style:  Vim::get_session_status(%{sessionfile})
#        method call style: vim->get_session_status(%{$url,sessionfile})
#        where
#           sessionfile - full path file name where session is saved 
# Output: status 
# --------------------------------------------------------------------------------

sub get_session_status {
   my $self = undef;
   my $url;
   my $session_file;
   my %args;

   my ($first_arg) = @_;
   if ($first_arg && ref $first_arg eq 'Vim') {
      ($self, %args) = @_;
       $url = $self->{service_url};
   } else {
      %args = @_;
      unless ($args{service_url}) {
         croak "service_url is a required argument to 'Vim::get_session_status'";
      }
      $url = $args{service_url};
   }
   if ($args{session_file}) {
      $session_file = $args{session_file};
      my $vim_soap = SoapClient->new($url);
      $vim_soap->load_session($session_file);
      return validate_vim_soap($vim_soap);
   } else {
      return validate_vim_soap($self->{vim_service}{vim_soap});
   }
}


# --------------------------------------------------------------------------------
# Description: Get the status of session using session id.
# Input: subroutine style:  Vim::get_session_id_status(%{sessionid})
#        method call style: vim->get_session_id_status(%{$url,sessionid})
#        where
#           session - session id of a particular session 
# Output: status 
# --------------------------------------------------------------------------------

sub get_session_id_status {
   my $self = undef;
   my $url;
   my $session_id;
   my %args;

   my ($first_arg) = @_;
   if ($first_arg && ref $first_arg eq 'Vim') {
      ($self, %args) = @_;
       $url = $self->{service_url};
   } else {
      %args = @_;
      unless ($args{service_url}) {
         croak "service_url is a required argument to 'Vim::get_session_id_status'";
      }
      $url = $args{service_url};
   }

   croak "session_id is a required argument to 'get_session_id_status'"
      unless defined $args{service_url};
   $session_id = $args{session_id};
   my $vim_soap = SoapClient->new($url);
   $vim_soap->load_session_id($session_id);
   my $status = validate_vim_soap($vim_soap);
   return $status;
}

sub validate_vim_soap {
   my ($vim_soap) = @_;
   my $url = $vim_soap->{url};
   my $status = 1;
   my $soap_env_body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
   $soap_env_body = $soap_env_body."<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">";
   $soap_env_body = $soap_env_body."<soapenv:Body>";
   $soap_env_body = $soap_env_body."<CurrentTime xmlns=\"urn:vim2\">";
   $soap_env_body = $soap_env_body."<_this type=\"ServiceInstance\">ServiceInstance</_this>";
   $soap_env_body = $soap_env_body."</CurrentTime>";
   $soap_env_body = $soap_env_body."</soapenv:Body>";
   $soap_env_body = $soap_env_body."</soapenv:Envelope>";

   my $http_header = HTTP::Headers->new(Content_Type => 'text/xml',
                                        Content_Length => byte_length($soap_env_body));
   my $request = HTTP::Request->new('POST',
                                    $url,
                                    $http_header,
                                    $soap_env_body);

   my $response = $vim_soap->{user_agent}->request($request);
   my $xml_parser = XML::LibXML->new;
   my $parsed_response;
   my $connection_error_message = 
      "Error while testing status of connection '$url': ";

   eval { $parsed_response = $xml_parser->parse_string($response->content) };
   if ($@) {
      #
      # If it's desired to provide a specific message for an attempt to access via HTTP when only HTTPS is supported, then inspect $@ ....
      $status = $connection_error_message . $response->content . "\n";
   }
   my $body = $parsed_response->documentElement()->getChildrenByTagName('soapenv:Body')->shift;
   my $return_val = $body->getChildrenByTagName($response->content)->shift;
   if (! $return_val) {
      $return_val = $body->getChildrenByTagName('soapenv:Fault')->shift;
      if($return_val) {
         my $fault_code = $return_val->getChildrenByTagName('faultstring')->shift;
         $status = $connection_error_message . $fault_code->textContent. "\n";

         # is this code reachable? $return_val is false
         if (!$return_val) {
            $status = $connection_error_message . $response->content . "\n";
         }
      }
   }
   return $status;
}

sub byte_length {
    my ($string) = @_;

    use bytes;
    return length($string);
}

sub set_logout_on_disconnect {
   my $self = &_select_vim;
   croak "Session is undef" unless defined $self;
   $self->{_logout_on_disconnect} = 1;
}

sub unset_logout_on_disconnect {
   my $self = &_select_vim;
   croak "Session is undef" unless defined $self;
   $self->{_logout_on_disconnect} = 0;
}

sub is_logout_on_disconnect {
   my $self = &_select_vim;
   croak "Session is undef" unless defined $self;
   return $self->{_logout_on_disconnect};
}

# --------------------------------------------------------------------------------
# Description: Load a session cookie from a specified file or by using
#    a supplied session id.
# Input: subroutine style:  Vim::load_session(%{service_url, session_file})
#        where
#           session_file - full path file name where session is saved to,
#              as a cookie file
#        or
#           session_id - session id token (equivalent of cookie file contents)
#        Also, 
#           service_url - the URL of the server to which the client connects
#              (host name in session file will replace one in service_url)
#           server, protocol, path, port - alternative to specifying
#              service_url
# Output: none
# --------------------------------------------------------------------------------
sub load_session {
   my %args;
   my $using_vim_global = 1;

   my $self = $vim_global;
   if (ref $_[0] eq 'Vim') {
     $self = shift;
     $using_vim_global = 0;
   }
   %args = @_;

   my $server = delete($args{server});
   my $protocol = delete($args{protocol});
   my $path = delete($args{path});
   my $port = delete($args{port});
   my $url = delete($args{service_url});

   my $file = delete $args{session_file} || Opts::get_option('sessionfile');
   my $session_id = delete $args{session_id};

   if (defined $file and defined $session_id) {
      croak "Only one of 'session_file' and 'session_id' can be supplied to 'load_session'";
   }

   if (keys %args) {
      croak "Unrecognized arg(s) " . 
            join(', ', sort keys %args) . " to 'load_session'";
   }
   unless (defined $file or defined $session_id) {
      croak "No session_file argument to 'load_session' and no 'sessionfile' option set";
   }

   if (defined $file) {
      local *SFILE;
      my $line;
      
      open SFILE, $file or die "Can't open session file \'$file\'\n";
      $line = <SFILE>;
      $line = <SFILE>;
   
      unless (defined $line) {
         croak "Session file ended unexpectedly";
      }
      chomp $line;
      $server = $1 if $line =~ /\w*\s*domain=(.*).local/;
      $server = $1 if $line =~ /\w*\s*domain=(.*?);/;
      close SFILE or die $!;
   }
   $url = Opts::construct_service_url(
      server => $server,
      protocol => $protocol,
      servicepath => $path,
      port => $port,
      url => $url,
   );

   #
   # reuse the Vim object if we started with one - otherwise we wind 
   # up returning a different Vim than the one we were called with, = bad...
   #
   if (defined $self) {
      $self->clear_session;
   } else {
      $self = Vim->new(service_url => $url);
   }
   $self->{service_url} = $url;
   if ($using_vim_global) {
      $vim_global = $self;
      Opts::set_option('url', $url);
   }
   
   #
   # Load the appropriate Runtime/Stubs if not done yet, and
   # set the default namespace.
   #
   unless ($server_version) {
      $server_version = query_server_version($url);
   }
      
   unless ($vim_namespace) {
      $vim_namespace = "vim$server_version";
      require VMware::VIMRuntime;
      VIMRuntime->initialize($server_version);         
   }
      
   my $si_mo_ref = ManagedObjectReference->new(
      type => 'ServiceInstance',
      value => 'ServiceInstance'
   );
   $self->{vim_service} = VimService->new($self->{service_url});

   # bug 264430
   if ($session_id) {
      my $status = $self->get_session_id_status(
         service_url => $url,
         session_id => $session_id,
      );
      if ($status eq $SESSION_STATUS_OK) {
         $self->{vim_service}->load_session_id($session_id);
      } else {
         die $status;
      }
   } else {
      my $status = Vim::get_session_status(
        service_url => $url, 
        session_file => $file,
      );
      if ($status eq $SESSION_STATUS_OK) {
         $self->{vim_service}->load_session($file);
      } else {
         die $status;
      }
   }
   #
   # The presumption is that if we "logged on" via an existing
   # session, we won't log out the session when doing a standard
   # disconnect.
   #
   $self->unset_logout_on_disconnect;

   my $sc = Util::check_fault(
      $self->{vim_service}->RetrieveServiceContent(_this => $si_mo_ref)
   );
   $self->{service_content} = $sc;

   $vim_connection{$self} = $self;
   return $self;
}

# --------------------------------------------------------------------------------
# Description: Tear down the client side connection in the Vim object.
#   This does not do a server side log out - the server connection
#   will remain live until it times out or until a log out is performed.
# Input:  none
# Output: none
# --------------------------------------------------------------------------------
sub clear_session {
   my $self = &_select_vim;
   if (defined $self->{vim_service}) {
      # unload clears the cookie jar, but that kind of precision isn't
      # useful, because if we have to log in again we will create a
      # whole new VimService object ... so let's just delete it entirely
      # $self->{vim_service}->unload_session();
      $self->{vim_service} = undef;
   }
   $self->{service_content} = undef;
   $self->set_logout_on_disconnect;
   # Leave $self->{service_url} in place so that we can log in again
   # through this object.
   return;
}

# --------------------------------------------------------------------------------
# Description: Return the current VimService object instance.
# Input:  none
# Output: a VimService object instance
# --------------------------------------------------------------------------------
sub get_vim_service {
   my $self = &_select_vim;
   Carp::croak("Can't get vim_service - the session object is uninitialized or not logged in")
      unless $self->{vim_service};
   return $self->{vim_service};
}

# --------------------------------------------------------------------------------
# Description: Return the current service_url.
# --------------------------------------------------------------------------------
sub get_service_url {
   my $self = &_select_vim;
   return $self->{service_url};
}

# --------------------------------------------------------------------------------
# Description: Return a ServiceInstance object instance.
# Input:  none
# Output: a ServiceInstance object instance
# --------------------------------------------------------------------------------
sub get_service_instance {
   my $self = &_select_vim;
   my $si_mo_ref = ManagedObjectReference->new(type  => 'ServiceInstance',
                                               value => 'ServiceInstance');
   return $self->get_view(mo_ref => $si_mo_ref);
}

# --------------------------------------------------------------------------------
# Description: Return a ServiceContent object instance.
# Input:  none
# Output: a ServiceContent object instance
# --------------------------------------------------------------------------------
sub get_service_content {
   my $self = &_select_vim;
   Carp::croak("Can't get service_content - the session object is uninitialized or not logged in")
      unless $self->{service_content};
   return $self->{service_content};
}

sub match {
   my ($pat, $str) = @_;
   
   # bug 178470
   $str = uri_unescape($str);
   
   if (!ref($pat)) {
      return $str eq $pat;
   } elsif (ref($pat) ne 'Regexp') {
      die "Error: Regexp or string arg expected.\n";
   }
   return $str =~ /$pat/;
}

sub mismatch {
   my ($pat, $str) = @_;
   
   # bug 178470
   $str = uri_unescape($str);
   
   if (!ref($pat)) {
      return $str ne $pat;
   } elsif (ref($pat) ne 'Regexp') {
      die "Error: Regexp or string arg expected.\n";
   }
   return $str !~ /$pat/;
}

# ----------------------------------------------------------------------------------
# Description: Search the inventory tree for 1st managed entity that matches the 
#              specified entity type.  The search begins with the root folder 
#              unless the begin_entity parameter is specified.
# Input: subroutine style:  Vim::find_entity_view(%{view_type, begin_entity, filter})
#        method call style: vim->find_entity_view(%{view_type, begin_entity, filter})
#        where
#           view_type     - Folder | HostSystem | ResourcePool | VirtualMachine |
#                           ComputeResource | DataCenter | ClusterComputeResource
#           begin_entity  - starting managed object reference
#           filter        - a hash of one or more name value pair
# Output: a managed object view instance
# ----------------------------------------------------------------------------------
sub find_entity_view {
   my $self = &_select_vim;
   my %args = @_;
   my $service = $self->{vim_service};
   my $sc = $self->{service_content};

   if (! exists($args{view_type})) {
      Carp::confess('view_type argument is required');
   }
   my $view_type = $args{view_type};

   eval {
      VIMRuntime::load($view_type);
   };
   if ($@) {
      Carp::croak "Unable to load class '$view_type' for find_entity_view(): Perhaps it is not a valid managed entity type";
   }
   
   delete $args{view_type};
   if (! $view_type->isa('EntityViewBase')) {
      Carp::confess("$view_type is not a ManagedEntity");
   }
   my $properties = "";
   if (exists ($args{properties})) {
      if (defined($args{properties})) {
         $properties = $args{properties};
      }
      delete $args{properties};
   }
   my $begin_entity = $sc->rootFolder;
   if (exists ($args{begin_entity})) {
      $begin_entity = $args{begin_entity};
      delete $args{begin_entity};
   }   
   my $filter = {};
   if (exists ($args{filter})) {
      $filter = $args{filter};
      delete $args{filter};
   }
   
   my @remaining = keys %args;
   if (@remaining > 0) {
      Carp::confess("Unexpected argument @remaining");
   }
   my %filter_hash;
   foreach (keys %$filter) {
      my $key = $_;
      my $keyvalue = $filter->{$_};
      my $index = index($_, "-");
      if($index == 0) {
         $key = substr($key,1);
      }
      $filter_hash{$key} = $keyvalue;
   }
   my $property_spec = PropertySpec->new(all => 0,
                                         type => $view_type->get_backing_type(),
                                         pathSet => [keys %filter_hash]);

   my $service_url = $self->{service_url};
   my %result = query_api_supported($service_url);
   my $is_exists_vimversion_xml = $result{"supported"};
   my $property_filter_spec;
   if($is_exists_vimversion_xml eq '1') {
      $property_filter_spec = 
         $view_type->get_search_filter_spec_v40($begin_entity, [$property_spec], %result);
   }
   else {
      $property_filter_spec = 
         $view_type->get_search_filter_spec($begin_entity, [$property_spec]);
   }

   my $obj_contents =
      $service->RetrieveProperties(_this => $sc->propertyCollector,
                                   specSet => $property_filter_spec);   
   my $result = Util::check_fault($obj_contents);   
   my $filtered_obj;
   foreach (@$result) {
      my $obj_content = $_;
      if (keys %$filter == 0) {
         $filtered_obj = $obj_content->obj;
         last;
      }

      my %prop_hash;    
      my $prop_set = $obj_content->propSet;
      if (! $prop_set) {
         next;
      }
      foreach (@$prop_set) {
         $prop_hash{$_->name} = $_->val;
      }
      my $matched = 1;
      foreach (keys %$filter) {
         my $index = index($_, "-");
         my $regex = $filter->{$_};
         my $flag = 0;
         if($index == 0) {
            $_ = substr($_,1);
            $flag=1;
         }
         if (exists ($prop_hash{$_})) {         
            my $val;
            if (ref $prop_hash{$_}) {
               my $class = ref $prop_hash{$_};
               if ($class->isa("SimpleType")) {
                  $val = $prop_hash{$_}->val();
               } else {
                  Carp::croak("Filtering is only supported for Simple Types\n");
               }
            } else {
               $val = $prop_hash{$_};
            }
            
            if($flag == 0) {
               if (not match($regex,$val)) {
                  $matched = 0;
                  last;
               }
            }
            else {
               if (not mismatch($regex,$val)) {
                  $matched = 0;
                  last;
               }
            }
         }
      }
      if ($matched) {
         $filtered_obj = $obj_content->obj;
      }
   }
   if (! $filtered_obj) {
      return undef;
   } else {
      return $self->get_view(mo_ref => $filtered_obj,
                             view_type => $view_type,
                             properties => $properties);
   }
}

# ----------------------------------------------------------------------------------
# Description: Search the inventory tree for all managed entity that matches the 
#              specified entity type.  The search begins with the root folder 
#              unless the begin_entity parameter is specified.
# Input: subroutine style:  Vim::find_entity_views(%{view_type, begin_entity, filter})
#        method call style: vim->find_entity_views(%{view_type, begin_entity, filter})
#        where
#           view_type     - Folder | HostSystem | ResourcePool | VirtualMachine |
#                           ComputeResource | DataCenter | ClusterComputeResource
#           begin_entity  - starting managed object reference
#           filter        - a hash of one or more name value pair
# Output: a reference to an array managed object view instances
# ----------------------------------------------------------------------------------
sub find_entity_views {
   my $self = &_select_vim;
   my %args = @_;
   my $service = $self->{vim_service};
   my $sc = $self->{service_content};   
   
   if (! exists($args{view_type})) {
      Carp::confess('view_type argument is required');
   }
   my $view_type = $args{view_type};
   
   eval {
      VIMRuntime::load($view_type);
   };
   if ($@) {
      Carp::croak "Unable to load class '$view_type' for find_entity_views(): Perhaps it is not a valid managed entity type";
   }   
   
   delete $args{view_type};
   if (! $view_type->isa('EntityViewBase')) {
      Carp::confess("$view_type is not a ManagedEntity");
   }
   my $begin_entity = $sc->rootFolder;
   if (exists ($args{begin_entity})) {
      $begin_entity = $args{begin_entity};
      delete $args{begin_entity};
   }
   my $filter = {};
   if (exists ($args{filter})) {
      $filter = $args{filter};
      delete $args{filter};
   }
   my $properties = "";
   if (exists ($args{properties})) {
      if (defined($args{properties})) {
         $properties = $args{properties};
      }
      delete $args{properties};
   }
   my @remaining = keys %args;
   if (@remaining > 0) {
      Carp::confess("Unexpected argument @remaining");
   }
   
   my %filter_hash;
   foreach (keys %$filter) {
      my $key = $_;
      my $keyvalue = $filter->{$_};
      my $index = index($_, "-");
      if($index == 0) {
         $key = substr($key,1);
      }
      $filter_hash{$key} = $keyvalue;
   }
   
   my $property_spec = PropertySpec->new(all => 0,
                                         type => $view_type->get_backing_type(),
                                         pathSet => [keys %filter_hash]);

   my $service_url = $self->{service_url};
   my %result = query_api_supported($service_url);
   my $is_exists_vimversion_xml = $result{"supported"};
   my $property_filter_spec;
   if($is_exists_vimversion_xml eq '1') {
      $property_filter_spec = 
         $view_type->get_search_filter_spec_v40($begin_entity, [$property_spec], %result);
   }
   else {
      $property_filter_spec = 
         $view_type->get_search_filter_spec($begin_entity, [$property_spec]);
   }

   my $obj_contents =
      $service->RetrieveProperties(_this => $sc->propertyCollector,
                                   specSet => $property_filter_spec);   
   my $result = Util::check_fault($obj_contents);   
   my @filtered_objs;
   foreach (@$result) {
      my $obj_content = $_;
      if (keys %$filter == 0) {
         push @filtered_objs, $obj_content->obj;
         next;
      }

      my %prop_hash;    
      my $prop_set = $obj_content->propSet;
      if (! $prop_set) {
         next;
      }
      foreach (@$prop_set) {
         $prop_hash{$_->name} = $_->val;
      }
      my $matched = 1;
      foreach (keys %$filter) {
         my $index = index($_, "-");
         my $regex = $filter->{$_};
         my $flag = 0;
         if($index == 0) {
            $_ = substr($_,1);
            $flag=1;
         }
         if (exists ($prop_hash{$_})) {
            my $val;
            if (ref $prop_hash{$_}) {
               my $class = ref $prop_hash{$_};
               if ($class->isa("SimpleType")) {
                  $val = $prop_hash{$_}->val();
               } else {
                  Carp::croak("Filtering is only supported for Simple Type\n");
               }
            } else {
               $val = $prop_hash{$_};
            }
	    
            if($flag == 0) {
               if (not match($regex,$val)) {
                  $matched = 0;
                  last;
               }
            }
            else {
               if (not mismatch($regex,$val)) {
                  $matched = 0;
                  last;
               }
            }
         }
      }
      if ($matched) {
         push @filtered_objs, $obj_content->obj;
      }
   }
   if (! @filtered_objs) {
      return [];
   } else {
      return $self->get_views(mo_ref_array => \@filtered_objs,
                              view_type => $view_type,
                              properties => $properties);
   }   
}

# ----------------------------------------------------------------------------------
# Description: Retrieve the properties of a single managed object. 
# Input: subroutine style:  Vim::get_view(%{mo_ref, view_type})
#        method call style: vim->get_view(%{mo_ref, view_type})
#        where
#           mo_ref     - a managed object reference
#           view_type  - the type of view to construct from the managed object
# Output: a managed object view instance
# ----------------------------------------------------------------------------------
sub get_view {
   my $self = &_select_vim;
   my %args = @_;
   my $service = $self->{vim_service};
   
   if (! exists($args{mo_ref})) {
      Carp::confess("mo_ref argument is required");
   }
   my $mo_ref = $args{mo_ref};
   my $view_type = $mo_ref->type;
   if (exists ($args{view_type})) {
      $view_type = $args{view_type};
   }
   my $properties = "";
   if (exists($args{properties}) && 
       defined($args{properties}) && 
       $args{properties} ne "") {
      $properties = $args{properties};
   }
   my $view = $view_type->new($mo_ref, $self);
   $view->update_view_data($properties);
   return $view;
}

# ----------------------------------------------------------------------------------
# Description: Retrieve the properties of a set of managed object. 
# Input: subroutine style:  Vim::get_views(%{mo_ref_array, view_type})
#        method call style: vim->get_views(%{mo_ref_array, view_type})
#        where
#           mo_ref_array  - a reference to an array of managed object references
#           view_type     - the type of view to construct from the managed objects
# Output: a reference to an array managed object view instances
# ----------------------------------------------------------------------------------
sub get_views {
   my $self = &_select_vim;
   my %args = @_;
   my $service = $self->{vim_service};
   my $sc = $self->{service_content};

   if (! exists($args{mo_ref_array})) {
      Carp::confess("mo_ref_array argument is required");
   }
   my $mo_refs = $args{mo_ref_array};
   if (!defined($mo_refs) ||(@$mo_refs == 0)) {
      # Map an empty list of mo_refs to an empty list of views
      return [];
   }
   my $mo_ref = @$mo_refs[0];
   my $view_type = $mo_ref->type;
   if (exists ($args{view_type})) {
      $view_type = $args{view_type};
   }
     
   my $property_spec = $view_type->get_property_spec();
   my @object_specs;
   foreach (@$mo_refs) {
      push @object_specs, ObjectSpec->new(obj => $_);
   }
   my $prop_filter_spec = PropertyFilterSpec->new(propSet => $property_spec,
                                                  objectSet => \@object_specs);

   my $propertyCollector = $sc->propertyCollector;

   my $properties = "";
   if (exists($args{properties}) && 
       defined($args{properties}) && 
       $args{properties} ne "") {
      $properties = $args{properties};
      my $ptr = $prop_filter_spec->propSet;
      my $obj = $$ptr[0];
      $obj->all(0);  
      $obj->pathSet ($args{properties});
   }

   my $obj_contents =
      $service->RetrieveProperties(_this => $propertyCollector,
                                   specSet => $prop_filter_spec);
   Util::check_fault($obj_contents);
   my @views;
   foreach (@{$obj_contents->result}) {
      my $view = $view_type->new($_->obj, $self);
      $view->set_view_data($_, $properties);
      push @views, $view;
   }
   return \@views;
}

# --------------------------------------------------------------------------------
# Description: Close the connection to the server.
# Input:  none
# Output: none
# --------------------------------------------------------------------------------
sub logout {
   my $self = ref($_[0]) eq 'Vim' ? $_[0] : $vim_global;
   if (defined $self and 
       $self->{vim_service} and
       $self->{vim_service}->get_session_loaded and
       $self->{service_content}) {
      $self->{vim_service}->Logout(
         _this => $self->{service_content}->sessionManager
      );
   }
   $self->clear_session;
   return;
}

1;
##################################################################################



##################################################################################
package ViewBase;

sub new {
   my ($class, $mo_ref, $vim) = @_;
   if (! $mo_ref) {
      Carp::confess("Missing required mo_ref argument");
   }
   my $self = { mo_ref => $mo_ref,
                vim => $vim };
   bless $self, $class;
}

# bug 226075
sub serialize {
   my ($self, $tag, $show_type) = @_;
   my $mo_ref = $self->{mo_ref};
   if($show_type) {
      return $mo_ref->serialize($tag, $show_type);   
   } else {
      return $mo_ref->serialize($tag);
   }
}

# bug 231138
sub get_vim {
   return shift->{vim};
}

sub get_backing_type {
   my $class = shift;
   return $class;
}

sub get_property_spec {
   my $class = shift;
   return [PropertySpec->new(all => 1,
                             type => $class)];
}

sub get_property_filter_spec {
   my ($class, $mo_ref) = @_;
   my $property_spec = $class->get_property_spec();
   my $object_spec = ObjectSpec->new(obj => $mo_ref);
   return PropertyFilterSpec->new(propSet => $property_spec,
                                  objectSet => [ $object_spec ]);   
}

sub update_view_data {
   my $self = shift;
   my $properties = shift;
   my $service = $self->{vim}->get_vim_service();
   my $property_filter_spec = (ref $self)->get_property_filter_spec($self->{mo_ref});
   my $propertyCollector = $self->{vim}->get_service_content()->propertyCollector;
   if (defined($properties) && $properties ne "") {
      my $ptr = $property_filter_spec->propSet;
      my $obj = $$ptr[0];
      $obj->all(0);  
      $obj->pathSet ($properties);
   }
   my $obj_contents =
      $service->RetrieveProperties(_this => $propertyCollector,
                                   specSet => $property_filter_spec);
   Util::check_fault($obj_contents);
   foreach (@{$obj_contents->result}) {
      $self->set_view_data($_, $properties);
   }
}

sub set_view_data {
   my ($self, $obj_content, $properties) = @_;
   my $prop_set = $obj_content->propSet;
   foreach (@$prop_set) {
      my $name = $_->name;
      if (!$properties || $properties eq "") {
         my @path_elements = split /\./, $name;
         $name = pop @path_elements;
      }
      $self->{$name} = $_->val;
   }
}


sub invoke {
   my ($self, $method, %args) = @_;
   my $runtime = $self->{vim}->get_vim_service();
   my $mo_ref = $self->{mo_ref};
   if (! $mo_ref) {
      Carp::confess("Required mo_ref argument not found");
   }
   $runtime->$method(_this => $mo_ref, %args);
}

sub get_property {
   my ($self, $path) = @_;
   my @subpaths = ();
   my $val;
   while ($path) {
      if (exists $self->{$path}) {
         $val = $self->{$path};
         last;
      } elsif ($path =~ /^(.+)\.([^.]+)$/) {
         $path = $1;
         unshift @subpaths, $2;
      }
   }
   if (defined($val)) {
      foreach (@subpaths) {
         $val = $val->{$_};
      }
   }
   return $val;
}

# bug 177573
sub waitForTask {
   my ($self, $task_ref, $progesscallbackfunc) = @_;
   my $task_view = $self->{vim}->get_view(mo_ref => $task_ref);
   my $progress = -1;
   while (1) {
      my $info = $task_view->info;
      if ($info->state->val eq 'success') {
         return $info->result;
      } elsif ($info->state->val eq 'error') {
         my $soap_fault = SoapFault->new;
         $soap_fault->name($info->error->fault);
         $soap_fault->detail($info->error->fault);
         my $errorMessage = $info->error->localizedMessage;
         if (defined ($info->error->fault->faultMessage)) {
            my $messages = $info->error->fault->faultMessage;
            if (scalar($messages) > 0 && defined $$messages[0]->message) {
               $errorMessage .= $$messages[0]->message;
            }
         }
         $soap_fault->fault_string($errorMessage);
         # bug 266936, 317279, 275446
         die $soap_fault;
      }
      if(defined $progesscallbackfunc) {
         if(defined $info->progress && $info->progress != $progress) {
            &$progesscallbackfunc($info->progress);
            $progress = $info->progress;
         }
      }
      sleep 2;
      $task_view->update_view_data();
   }
}

1;
##################################################################################


##################################################################################
package EntityViewBase;
our @ISA = qw(ViewBase);

sub get_search_filter_spec_v40 {
   my ($class, $mo_ref, $property_spec, %apiversions) = @_;
   my $folderTraversalSpec =
      TraversalSpec->new(name => 'folderTraversalSpec',
                         type => 'Folder',
                         path => 'childEntity',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => 'folderTraversalSpec'),
                                       SelectionSpec->new(name => 'datacenterHostTraversalSpec'),
                                       SelectionSpec->new(name => 'datacenterVmTraversalSpec',),
                                       SelectionSpec->new(name => 'datacenterDatastoreTraversalSpec',),
                                       SelectionSpec->new(name => 'datacenterNetworkTraversalSpec',),
                                       SelectionSpec->new(name => 'computeResourceRpTraversalSpec'),
                                       SelectionSpec->new(name => 'computeResourceHostTraversalSpec'),
                                       SelectionSpec->new(name => 'hostVmTraversalSpec'),
                                       SelectionSpec->new(name => 'resourcePoolVmTraversalSpec'),
                                       ]);

   my $datacenterDatastoreTraversalSpec =
      TraversalSpec->new(name => 'datacenterDatastoreTraversalSpec',
                         type => 'Datacenter',
                         path => 'datastoreFolder',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => "folderTraversalSpec")]);

   my $datacenterNetworkTraversalSpec =
      TraversalSpec->new(name => 'datacenterNetworkTraversalSpec',
                         type => 'Datacenter',
                         path => 'networkFolder',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => "folderTraversalSpec")]);

   my @arr_select_set;
   my $property_filter_spec = get_search_filter_spec($class, $mo_ref, $property_spec);
   my $object_set = $property_filter_spec->objectSet;
   my $arr = $object_set->[0]->selectSet;

   push(@arr_select_set, $folderTraversalSpec);
   push(@arr_select_set, $datacenterDatastoreTraversalSpec);
   push(@arr_select_set, $datacenterNetworkTraversalSpec);
   
   foreach (@$arr) {
      if (!($_->name eq "folderTraversalSpec")) {
         push(@arr_select_set, $_);
      }
   }

   my $obj_spec = ObjectSpec->new(obj => $mo_ref,
                                  skip => 0,
                                  selectSet => \@arr_select_set);

   return PropertyFilterSpec->new(propSet => $property_spec,
                                  objectSet => [$obj_spec]);
}

sub get_search_filter_spec {   
   my ($class, $mo_ref, $property_spec) = @_;
   my $resourcePoolTraversalSpec =
      TraversalSpec->new(name => 'resourcePoolTraversalSpec',
                         type => 'ResourcePool',
                         path => 'resourcePool',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => 'resourcePoolTraversalSpec'),
                                       SelectionSpec->new(name => 'resourcePoolVmTraversalSpec')]);      

   my $resourcePoolVmTraversalSpec =
      TraversalSpec->new(name => 'resourcePoolVmTraversalSpec',
                         type => 'ResourcePool',
                         path => 'vm',
                         skip => 0);   

   my $computeResourceRpTraversalSpec =
      TraversalSpec->new(name => 'computeResourceRpTraversalSpec',
                         type => 'ComputeResource',
                         path => 'resourcePool',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => 'resourcePoolTraversalSpec'),
                                       SelectionSpec->new(name => 'resourcePoolVmTraversalSpec')]);      
      
   
   my $computeResourceHostTraversalSpec =
      TraversalSpec->new(name => 'computeResourceHostTraversalSpec',
                         type => 'ComputeResource',
                         path => 'host',
                         skip => 0);
         
   my $datacenterHostTraversalSpec =
      TraversalSpec->new(name => 'datacenterHostTraversalSpec',
                         type => 'Datacenter',
                         path => 'hostFolder',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => "folderTraversalSpec")]);
   
   my $datacenterVmTraversalSpec =
      TraversalSpec->new(name => 'datacenterVmTraversalSpec',
                         type => 'Datacenter',
                         path => 'vmFolder',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => "folderTraversalSpec")]);

   my $hostVmTraversalSpec =
      TraversalSpec->new(name => 'hostVmTraversalSpec',
                         type => 'HostSystem',
                         path => 'vm',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => "folderTraversalSpec")]);
      
   my $folderTraversalSpec =
      TraversalSpec->new(name => 'folderTraversalSpec',
                         type => 'Folder',
                         path => 'childEntity',
                         skip => 0,
                         selectSet => [SelectionSpec->new(name => 'folderTraversalSpec'),
                                       SelectionSpec->new(name => 'datacenterHostTraversalSpec'),
                                       SelectionSpec->new(name => 'datacenterVmTraversalSpec',),
                                       SelectionSpec->new(name => 'computeResourceRpTraversalSpec'),
                                       SelectionSpec->new(name => 'computeResourceHostTraversalSpec'),
                                       SelectionSpec->new(name => 'hostVmTraversalSpec'),
                                       SelectionSpec->new(name => 'resourcePoolVmTraversalSpec'),
                                       ]);
   
   my $obj_spec = ObjectSpec->new(obj => $mo_ref,
                                  skip => 0,
                                  selectSet => [$folderTraversalSpec,
                                                $datacenterVmTraversalSpec,
                                                $datacenterHostTraversalSpec,
                                                $computeResourceHostTraversalSpec,
                                                $computeResourceRpTraversalSpec,
                                                $resourcePoolTraversalSpec,
                                                $hostVmTraversalSpec,
                                                $resourcePoolVmTraversalSpec]);
   
   return PropertyFilterSpec->new(propSet => $property_spec,
                                  objectSet => [$obj_spec]);
}

sub get_task_collector_view {
   my ($self, $recursion_option, %args) = @_;
   my $task_filter_spec = TaskFilterSpec->new;
   if (exists $args{filter}) {
      $task_filter_spec = $args{task_filter_spec};
   }
   $task_filter_spec->entity(
      TaskFilterSpecByEntity->new(entity => $self->{mo_ref},
                                  recursion => TaskFilterSpecRecursionOption->new($recursion_option)));
   my $task_mgr_view = $self->{vim}->get_view(mo_ref => $self->{vim}->get_service_content()->taskManager);
   my $task_collector = $task_mgr_view->CreateCollectorForTasks(filter => $task_filter_spec);
   return $self->{vim}->get_view(mo_ref => $task_collector);   
}

sub get_entity_only_tasks_collector_view {
   my ($self, %args) = @_;
   return $self->get_task_collector_view('self', %args);
}

sub get_all_tasks_view {
   my ($self, %args) = @_;
   return $self->get_task_collector_view('all', %args);   
}

sub get_event_collector_view {
   my ($self, $recursion_option, %args) = @_;
   my $event_filter_spec = EventFilterSpec->new;
   if (exists $args{filter}) {
      $event_filter_spec = $args{filter};
   }
   $event_filter_spec->entity(
      EventFilterSpecByEntity->new(entity => $self->{mo_ref},
                                   recursion => EventFilterSpecRecursionOption->new($recursion_option)));
   my $event_mgr_view = $self->{vim}->get_view(mo_ref => $self->{vim}->get_service_content()->eventManager);
   my $event_collector = $event_mgr_view->CreateCollectorForEvents(filter => $event_filter_spec);
   return $self->{vim}->get_view(mo_ref => $event_collector);
}

sub get_entity_only_events_view {
   my ($self, %args) = @_;
   $self->get_event_collector_view('self', %args);
}

sub get_all_events_view {
   my ($self, %args) = @_;
   $self->get_event_collector_view('all', %args);
}


1;
#########################################################

use 5.006001;
use strict;
use warnings;


#########################################################
package XmlUtil;

sub escape_xml_string {
   my $string = shift;
   if (defined $string) {
      $string =~ s/\&/\&amp;/g;
      $string =~ s/</\&lt;/g;
      $string =~ s/>/\&gt;/g;
   } else {
      $string = undef;
   }
   return $string;
}

sub get_first_child_element {
   my $parent_node = shift;
   my @child_nodes = $parent_node->childNodes;
   my $node;
   foreach $node (@child_nodes) {
      if ($node->nodeType == XML::LibXML::XML_ELEMENT_NODE) {
         return $node;
      }
   }
   return undef;
}

1;
#########################################################



#########################################################
package SoapFault;
use Encode;
use Data::Dumper;
use VMware::VIMRuntime;

VIMRuntime::make_get_set('SoapFault', 'name', 'detail', 'fault_string');

sub new {
   my ($class, $fault_node) = @_;
   my $self = {};
   if (! $fault_node) {
      return bless $self, $class;
   }
   
   my $detail_node = $fault_node->getChildrenByTagName('detail')->shift;
   if (defined($detail_node)) {
      my $fault_detail_child = XmlUtil::get_first_child_element($detail_node);
      my $faultName = $fault_detail_child->localname;
      $faultName =~ /(.*)Fault/;
      $self->{detail} = $1->deserialize($fault_detail_child);
      # bug 194241
      $self->{name} = $faultName;     
   } else {
      my $fault_code_node = $fault_node->getChildrenByTagName('faultcode')->shift;
      $self->{detail} = $fault_code_node->textContent;
   }
   
   my $fault_string_node = $fault_node->getChildrenByTagName('faultstring')->shift;
   $self->{fault_string} = $fault_string_node->textContent;
   return bless $self, $class;
}

use overload '""' => \&stringify;

sub stringify{
   my $self = shift;
   my $fault = "\nSOAP Fault:\n";
   $fault .=   "-----------\n";
   
   if (!Encode::is_utf8($self->{fault_string})) {
      $self->{fault_string} = decode_utf8($self->{fault_string});
   }
   $fault .= "Fault string: " . $self->{fault_string};
   # bug 297676
   if(defined $self->{name}) {
      if ($self->{name} =~ /(.*)=HASH/) {
         $fault .= "\nFault detail: " . $1;
      } else {
         $fault .= "\nFault detail: " . $self->{name};
      }
   }
   else {
      $fault .= "\nFault detail: ";
   }

   return $fault;
}

1;
#########################################################


#########################################################
package SoapResponse;

sub new {
   my ($class, $result, $fault) = @_;
   my $self = { result => $result,
                fault => $fault, };
   return bless $self, $class;
}

sub result {
   my ($self, $val) = @_;
   if ($val) {
      $self->{result} = $val;
      $self;
   } else {
      $self->{result};
   }
}

sub fault {
   my ($self, $val) = @_;
   if ($val) {
      $self->{fault} = $val;
      $self;
   } else {
      $self->{fault};
   }
}

1;
#########################################################



#########################################################
package SoapClient;

use Carp;
use Data::Dumper qw(Dumper);

my $soap_header  = <<'END';
<?xml version="1.0" encoding="UTF-8"?>
   <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                     xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soapenv:Body>
END

my $soap_footer = <<'END';
</soapenv:Body></soapenv:Envelope>
END


sub new {
   my ($class, $url) = @_;
   my $user_agent = LWP::UserAgent->new(agent => "VI Perl");
   my $cookie_jar = HTTP::Cookies->new(ignore_discard => 1);
   $user_agent->cookie_jar( $cookie_jar );
   $user_agent->protocols_allowed( ['http', 'https'] );
   $user_agent->conn_cache(LWP::ConnCache->new);
   my $self = { user_agent => $user_agent,
                url => $url, };
   return bless $self, $class;   
}

sub save_session {
   my ($self, $file) = @_;
   my $user_agent = $self->{user_agent};
   umask 0077;
   $user_agent->cookie_jar->save($file); 
   return;
}

sub load_session {
   my ($self, $file) = @_;
   my $user_agent = $self->{user_agent};
   $user_agent->cookie_jar->load($file);
   return;
}

sub unload_session {
   my ($self) = @_;
   my $user_agent = $self->{user_agent};
   my $cookie_jar = HTTP::Cookies->new(ignore_discard => 1);
   $user_agent->cookie_jar($cookie_jar);
   return;
}

sub get_session_loaded {
   my $self = shift;
   my $user_agent = $self->{user_agent};
   return defined $user_agent->cookie_jar and 
                  $user_agent->cookie_jar->as_string ne '';
}


sub get_session_id {
   my $self = shift;
   my $user_agent = $self->{user_agent};
   $user_agent->cookie_jar->as_string
      =~ m/(.*)vmware_soap_session=\"\\\"([0-9a-zA-Z-](.*)+)\\\"\"(.*)/;
   return $2;
}

sub load_session_id {
   my ($self, $id) = @_;
   my $user_agent = $self->{user_agent};
   # bug 264430
   my $url = URI->new($self->{url});
   my $host = $url->host();
   $id = '"' . $id . '"';
   my %hash = ();
   $user_agent->cookie_jar->set_cookie(
      0, 'vmware_soap_session', $id, '/',
      $host, undef, 1, undef, undef, 1, \%hash);
}

sub request {
   my ($self, $op_name, $body_content, $soap_action) = @_;
   my $user_agent = $self->{user_agent};
   my $url = $self->{url};

   if (!$soap_action) {
      $soap_action = '""';
   }

   my $namespace = Vim::get_vim_namespace;
   confess "Not logged in and/or no XML namespace set" unless $namespace;
   my $request_envelope =
      "$soap_header<$op_name xmlns=\"urn:$namespace\">$body_content</$op_name>$soap_footer";

   # http header
   my $http_header = HTTP::Headers->new(
                        Content_Type => 'text/xml',
                        SOAPAction => $soap_action,
                        Content_Length => byte_length($request_envelope));
   # request
   my $request = HTTP::Request->new('POST',
                                    $url,
                                    $http_header,
                                    $request_envelope);
   
   # send request
   Util::trace(3, "\nREQUEST: " . Dumper($request->content));
   my $response = $user_agent->request($request);
   Util::trace(3, "\nRESPONSE: " . Dumper($response->content) . "\n");
   
   my $xml_parser = XML::LibXML->new;   
   my $result;   
   eval { $result = $xml_parser->parse_string($response->content) };
   if ($@) {
      # response is not well formed xml - possibly be a setup issue
      die "SOAP request error - possibly a protocol issue: " . $response->content . "\n";
   }   
   my $body = $result->documentElement()->getChildrenByTagName('soapenv:Body')->shift;
   my $return_val = $body->getChildrenByTagName("${op_name}Response")->shift;
   if (! $return_val) {
      # must be fault
      $return_val = $body->getChildrenByTagName('soapenv:Fault')->shift;
      if (! $return_val) {
         # neither a valid response or a fault - fatal error
         die "Unexpected response from server: " . $response->content . "\n";
      }
      # should be trapped by caller
      return (undef, $return_val);
   } else {
      my @returnvals = $return_val->getChildrenByTagName('returnval');
      return (\@returnvals, undef);
   }
}

sub byte_length {
    my ($string) = @_;

    use bytes;
    return length($string);
}

1;
#########################################################


#########################################################
package PrimType;

sub new {
   my ($class, $val, $type_name) = @_;
   my $self = { val => $val , type_name => $type_name};
   return bless $self, $class;   
}

sub serialize {
   my ($self, $tag, $emit_type) = @_;
   my $val = $self->{val};   
   my $serialized_string = "<$tag>";
   if ($emit_type) {
      my $type_name = $self->{type_name};
      $serialized_string = "<$tag xsi:type=\"xsd:${type_name}\">";      
   }
   return $serialized_string .= "$val</$tag>";
}

sub val {
   my $self = shift;
   return $self->{val};
}

1;
#########################################################


#########################################################
package SimpleType;

use Encode;

sub new {
   my ($class, $val) = @_;
   my $self = { val => $val };
   return bless $self, $class;   
}

sub serialize {
   my ($self, $tag, $emit_type) = @_;
   my $val = encode_utf8($self->{val});
   my $serialized_string = "<$tag>";
   if ($emit_type) {
      my $type_name = ref $self;
      $serialized_string = "<$tag xsi:type=\"$type_name\">";      
   }
   return $serialized_string = "$serialized_string$val</$tag>";
}

sub deserialize {
   my ($class, $element_node) = @_;
   if (! defined($element_node)) {
      return undef;
   }
   my $content = $element_node->textContent;
   my $self = { val => decode_utf8($content) };
   return bless $self, $class;
}

sub val {
   my $self = shift;
   return $self->{val};
}

1;
##################################################################################



##################################################################################
package ComplexType;

sub deserialize {
   my ($class, $element_node) = @_;
   if (! defined($element_node)) {
      return undef;
   }
   my $type_node =
      $element_node->getAttributeNodeNS('http://www.w3.org/2001/XMLSchema-instance',
                                        'type');
   if ($type_node) {
      $class = $type_node->textContent;
   }
   my $self = {};
   my @property_list = $class->get_property_list();
   foreach (@property_list) {
      my ($property_name, $class_name, $isarray) = @$_; 
      my @child_nodes = $element_node->getChildrenByTagName($property_name);
      if (! @child_nodes) {
         next;
      }      
      my $property_val = [];   
      foreach (@child_nodes) {
         my $val;
         my $child_class_name = $class_name;
         
         if (defined $child_class_name) {
            my $child_type_node =
               $_->getAttributeNodeNS('http://www.w3.org/2001/XMLSchema-instance', 'type');
            if ($child_type_node) {
               $child_class_name = $child_type_node->textContent;
               if ($child_class_name =~ /^xsd:/) {
                  undef $child_class_name;
               }
            }
         }
         
         if ($child_class_name) {
            if ($child_class_name eq 'boolean') {
               if ($_->textContent eq 'true' or $_->textContent eq '1') {
                  $val = '1';
               } elsif ($_->textContent eq 'false' or $_->textContent eq '0') {
                  $val = '0';
               } else {
                  Carp::confess("Internal error: server returned '$val' as a boolean value");
               }
            } else {
               $val = $child_class_name->deserialize($_);
            }
         } else {
            $val = $_->textContent;
         }
         if ($isarray) {
            $property_val = [@$property_val, $val];
         } else {
            $property_val = $val;
         }
      }      
      my $propValType = ref $property_val;
      if ($propValType =~ /ArrayOf.*/) {
         my @keyvals = %$property_val;
         if (@keyvals) {
            $self->{$property_name} = pop @keyvals;
         }
      } else {
         $self->{$property_name} = $property_val;
      }
   } 
   return bless $self, $class;   
}


sub serialize {
   my ($self, $tag, $emit_type) = @_;
   my @property_list = $self->get_property_list();
   my $serialized_string = "<$tag>";
   if ($emit_type) {
      my $type_name = ref $self;
      $serialized_string = "<$tag xsi:type=\"$type_name\">";
   } 
   foreach (@property_list) {
      # bug 193402
      my ($property_name, $class_name, $isarray, $mandatory) = @$_;      
      if (! exists($self->{$property_name})) {
         if ($mandatory == 1) {
            Carp::confess "Mandatory property \"$property_name\" missing";
         }
         next;
      }
      my $val = $self->{$property_name};
      my @values;
      if ($isarray) {
         @values = @$val;
      } else {
         @values = $val;
      }
      foreach (@values) {
         if (defined ($class_name)) {
            if ($class_name eq 'boolean') {
               my $val;
               if (lc($_) eq 'true' or $_ eq '1') {
                  $val = '1';
               } elsif (lc($_) eq 'false' or $_ eq '0') {
                  $val = '0';
               } else {
                  Carp::confess "Cannot serialize boolean: acceptable values are true/false/1/0, got '$_'";
               }
               $serialized_string .= "<$property_name>" . XmlUtil::escape_xml_string($val) . "</$property_name>";                          
               next;
            }
            
            # complex type
            my $show_type;
            my $obj_type_name = ref $_;
            if ($class_name ne $obj_type_name) {               
               $show_type = 1;
               if ($class_name eq 'anyType' &&  ! $obj_type_name) {
                  # primitive going out as any -- treat them as xsd:string
                  if (defined ($_)) {
                     $serialized_string .=       
                        "<$property_name xsi:type=\"xsd:string\">" .
                        XmlUtil::escape_xml_string($_) . "</$property_name>";
                  }
                  next;
               }
            }
            if ($obj_type_name && $class_name eq 'ManagedObjectReference') {
               $obj_type_name = 'ManagedObjectReference';   
            }
            if ($class_name ne 'anyType') {
               if (! $obj_type_name || ! $obj_type_name->isa($class_name)) {
                  Carp::confess("Cannot serialize $property_name as $class_name");
               }
            }
            # bug 236635
            if (defined ($_)) {
               $serialized_string .= $_->serialize($property_name, $show_type);
            }
         } else {
            # primitive
            if (defined($_)) {
               $serialized_string .=       
                  "<$property_name>" . XmlUtil::escape_xml_string($_) . "</$property_name>";     
            }         
         }
      }
   }
   return $serialized_string .= "</$tag>";
}


sub new {
   my ($class, %args) = @_;

   # bug 194240
   arg_validation($class, %args);

   my $self = {};
   bless $self, $class;
   if (%args) {
      foreach ($class->get_property_list()) {
         my ($name, $type) = @$_;
         if (exists $args{$name}) {
            $self->{$name} = $args{$name};
         }
      }
   }
   return $self;
}

# bug 194240
sub arg_validation {
   my ($class, %args) = @_;
   my @arg_keys = keys %args;
   my @prop_list = $class->get_property_list();
   foreach(@arg_keys) {
      my $found = 0;
      my $arg = $_;
      foreach my $prop (@prop_list) {
         if($arg eq $prop->[0]) {
            $found = 1;
         }
      } 
      if($found == 0) {
         Carp::confess("Argument $arg is not valid");
      }
   }
}

sub get_property_list {
   return ();
}

1;
##################################################################################


##################################################################################   
package ManagedObjectReference;
use VMware::VIMRuntime;


our @ISA = qw(ComplexType);

our @property_list = (['type', undef],
                      ['value', undef]);
                      
VIMRuntime::make_get_set('ManagedObjectReference', 'type', 'value');

sub get_property_list {
   return @property_list;   
}

sub deserialize {
   my ($class, $element_node) = @_;
   if (! defined($element_node)) {
      return undef;
   }
   # deserialize ManagedObjectReference
   my $self = {
      type => $element_node->getAttribute('type'),
      value => $element_node->textContent
   };
   return bless $self, $class;
}

sub serialize {
   my ($self, $tag, $show_type) = @_;
   my $type = $self->{type};
   my $id = $self->{value};
   if ($show_type) {
      return "<$tag xsi:type=\"ManagedObjectReference\" type=\"$type\">$id</$tag>\n";
   } else {
      return "<$tag type=\"$type\">$id</$tag>\n";
   }
}

1;

# bug 158165, 399904
package main;
END {
   package Vim;
   for (keys %vim_connection) {
      my $vim = $vim_connection{$_};
      $vim->disconnect();
   }
   %vim_connection = ();
}
##################################################################################
__END__

## bug 480897

=head1 NAME

=item B<VICommon.pm>

=head1 HELP-LINKS

See the vSphere SDK for Perl Programming Guide at http://www.vmware.com/support/developer/viperltoolkit/ for reference documentation for the subroutines.

