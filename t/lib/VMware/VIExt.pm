#
# Copyright 2006 VMware, Inc.  All rights reserved.
#

use 5.006001;
use strict;
use warnings;

our $VERSION = '1.1';

use Archive::Zip qw(:ERROR_CODES);
use URI::URL;
use URI::Escape;

##################################################################################
package VIExt;

#
# Gets the host view. If connecting to vCenter,
# the vihost parameter is used to locate the target host
#
sub get_host_view {
   my ($require_host, $properties) = @_;
   my $service_content = Vim::get_service_content();
   my $host_view;
   if ($service_content->about->apiType eq 'VirtualCenter') {
      my $vihost = Opts::get_option('vihost');
      if ($require_host) {
         Opts::assert_usage(defined($vihost), 
                            "The --vihost option must be specified " . 
                            "when connecting to vCenter."); 
      }
      return undef unless (defined($vihost));
      if ($properties) {
         $host_view = Vim::find_entity_view(view_type => 'HostSystem', 
                                            filter => {'name' => "$vihost"},
                                            properties => $properties);      
      } else {
         $host_view = Vim::find_entity_view(view_type => 'HostSystem', 
                                            filter => {'name' => "$vihost"});
      }
   } else {
      #
      # assume only one entry if connected to an ESX 
      #
      if ($properties) {
         $host_view = Vim::find_entity_view (view_type => 'HostSystem',
                                             properties => $properties);
      } else {
         $host_view = Vim::find_entity_view (view_type => 'HostSystem');
      }
   }
   return $host_view;
}

#
# Displays error, disconnect from server and exit.
#
sub fail {
   my ($msg) = @_;
   print STDERR $msg, "\n";
   Util::disconnect();
   exit(1);
}

#
# Retrieves the file manager.
#
sub get_file_manager {
   my $service_content = Vim::get_service_content();
   my $fm = Vim::get_view (mo_ref => $service_content->{fileManager});
   return $fm;
}

#
# Retrieves the virtual disk manager.
#
sub get_virtual_disk_manager {
   my $service_content = Vim::get_service_content();
   my $fm = Vim::get_view (mo_ref => $service_content->{virtualDiskManager});
   return $fm;
}

#
# Returns the http request created with URL constructed based
# on the path and access mode.
#
sub build_http_request {
   my ($op, $mode, $service_url, $path, $ds, $dc) = @_;

   my $prefix;
   if ($mode eq "folder") {
      $prefix = "/folder";
   } elsif ($mode eq "host") {
      $prefix = "/host";
   } elsif ($mode eq "tmp") {
      $prefix = "/tmp";
   } elsif ($mode eq "docroot") {
      $prefix = "";
   }

   my $url_string;
   if ($path =~ /^\/folder/) {
      $url_string = $service_url->scheme . '://' . $service_url->authority . $path;
   } else {
      my @args = ();

      $url_string = $service_url->scheme . '://' . $service_url->authority . $prefix;
      if (defined($path) && $path ne "") {
         $url_string = $url_string . '/' . $path;
      }
      if (defined($ds) && $ds ne "") {
         push(@args, "dsName=$ds");
      }
      if (defined($dc) && $dc ne "") {
         push(@args, "dcPath=$dc");
      }
      if (scalar(@args)) {
         if ($mode eq "folder") {
             $url_string .= "?" . join('&', @args);
         }
      }
   }
   
   # bug 301386
   # Certain combinations of perl/lwp will construct 
   # corrupted HTTP request when utf-8 tagged URL is
   # involved so downgrading the utf8 url string.
   utf8::downgrade($url_string);
   my $url = URI::URL->new($url_string);
   my $request = HTTP::Request->new($op, $url);
}

sub parse_remote_path {
   my $remote_path = shift;
   my $mode = "folder";
   my $path = "";
   my $ds = "";
   my $dc = "";

   if ($remote_path =~ m@^\s*/host@) {
      $mode = "host";
      if ($remote_path =~ m@^\s*/host/(.*)$@) {
         $path = $1;
      }
   } elsif ($remote_path =~ m@^\s*/tmp@) {
      $mode = "tmp";
      if ($remote_path =~ m@^\s*/tmp/(.*)$@) {
         $path = $1;
      }
   } elsif ($remote_path =~ /\s*\[(.*)\]\s*(.*)$/) {
      $ds = $1;
      $path = $2;
   } elsif ($remote_path =~ m@^\s*/folder/?(.*)\?(.*)@) {
      ($path, my $args) = ($1, $2);
      my @fields = split(/\&/, $args);
      foreach (@fields) {
         if (/dsName=(.*)/) {
            $ds = URI::Escape::uri_unescape($1);
         } elsif (/dcPath=(.*)/) {
            $dc = URI::Escape::uri_unescape($1);
         }
      }
   } else {
      $path = $remote_path;
   }
   
   return ($mode, $dc, $ds, $path);
}


#
# Transfers a file to the server via http put.
#
sub do_http_put_file {
   my ($user_agent, $request, $file_name) = @_;

   $request->header('Content-Type', 'application/octet-stream');
   $request->header('Content-Length', -s $file_name);
   open(CONTENT, '< :raw', $file_name);
   sub content_source {
      my $buffer;
      my $num_read = read(CONTENT, $buffer, 102400);
      if ($num_read == 0) {
         return "";
      } else {
         return $buffer;
      }
   }

   $request->content(\&content_source);

   my $response;
   $response = $user_agent->request($request);

   close(CONTENT);
   return $response;
}

#
# Retrieves a file from the server via http get.
#
sub do_http_get_file {
   my ($user_agent, $request, $file_name) = @_;
   my $response;
   if (defined($file_name)) {
      $response = $user_agent->request($request, $file_name);
   } else {
      $response = $user_agent->request($request);
   }
   return $response;
}

#
# Unzips a file.
#
sub unzip_file {
   # XXX target_dir not used
   my ($zip_file, $target_dir) = @_;

   my $zip = Archive::Zip->new();

   my $status = $zip->read($zip_file);
   die "Read of $zip_file failed\n" if $status != Archive::Zip::AZ_OK;

   my @members = $zip->memberNames();

   $status  = $zip->extractTree();
   die "Extract of $zip_file failed\n" if $status != Archive::Zip::AZ_OK;

   return \@members;
}

#
# Placeholder for future gpg-based signature verification.
# Currently a no-op.
#
sub verify_signature {
   my ($file, $signature) = @_;
   my $failed = 0;

   unless (-e $file) {
      print "$file does not exist\n";
      $failed = 1;
   }
   unless (-e $signature) {
      print "$signature does not exist\n";
      $failed = 1;
   }
   return 0 if $failed;

   print "  ( skipping verification : $signature )\n";
   return 1;
}

#
# put $local_file into $remote_path of host.
#
sub http_put_file {
   my ($mode, $local_file, $remote_path, $remote_ds, $remote_dc) = @_;

   my $service = Vim::get_vim_service();
   my $service_url = URI::URL->new($service->{vim_soap}->{url});
   my $user_agent = $service->{vim_soap}->{user_agent};

   my $req = build_http_request("PUT", $mode, $service_url, 
                                $remote_path, $remote_ds, $remote_dc);
   unless ($req) {
      print STDERR "Unable to construct request : $remote_path.\n";
   } else {
      do_http_put_file($user_agent, $req, $local_file);
   }
}


#
# put $local_file into $remote_path of host.
# $remote_path is relative path relative to /tmp/
#
sub http_put_tmp_file {
   my ($local_file, $remote_path) = @_;
   http_put_file("tmp", $local_file, $remote_path, undef);
}


# Retrieves content at $remote_path.
# if $local_dest_path is given, also saves content
# to $local_dest_path.
sub http_get_file {
   my ($mode, $remote_path, $remote_ds, $remote_dc, $local_dest_path) = @_;

   my $service = Vim::get_vim_service();
   my $service_url = URI::URL->new($service->{vim_soap}->{url});
   my $user_agent = $service->{vim_soap}->{user_agent};

   my $req = build_http_request("GET", $mode, $service_url, 
                                $remote_path, $remote_ds, $remote_dc);
   unless ($req) {
      print STDERR "Unable to construct request : $remote_path.\n";
   } else {
      my $resp = do_http_get_file($user_agent, $req, $local_dest_path);
      if ($resp) {
         if (!$resp->is_success) {
            print STDERR "GET " . $req->uri . " unsuccessful : " . 
                         $resp->status_line . "\n";
         }
      } else {
         print STDERR "GET " . $req->uri . " unsuccessful : failed to get response\n";
      }
      return $resp;
   }

   return undef;
}

#
# Find the matching option by key
#
sub get_advoption_by_key {
   my ($ao, $key) = @_;

   # convert to dot notation
   $key =~ s/^\s*\///g; 
   $key =~ s/\//\./g; 

   my $optList = $ao->supportedOption();
   foreach my $optDef (@$optList) {
      if ($optDef->key eq $key) {
         my $optList = $ao->setting();
         foreach my $opt (@$optList) {
            if ($opt->key eq $key) {
               return ($optDef, $opt);
            }
         }
      }
   }

   return (undef, undef);
}

#
# Retrieve the type of the option
#
sub get_advoption_type {
   my $optType = shift;
   my $valType = "string"; 

   if (defined($optType)) {
      if ($optType->isa("IntOption")) {
         $valType = "int";
      } elsif ($optType->isa("LongOption")) {
         $valType = "long";
      } elsif ($optType->isa("FloatOption")) {
         $valType = "float";
      } elsif ($optType->isa("BoolOption")) {
         $valType = "boolean";
      }
   }

   return $valType;
}

#
# Sets the default value of the option
#
sub set_advoption_default {
   my ($ao, $key) = @_;
   my ($optDef, $opt) = get_advoption_by_key($ao, $key);
   if (defined($optDef) && defined($opt)) {
      my $valType = get_advoption_type(ref $optDef->optionType);

      my $defVal = $optDef->optionType->defaultValue;
      $defVal = "" unless defined($defVal);

      my $val = new PrimType($defVal, $valType);
      $opt->{value} = $val; 

      $ao->UpdateOptions(changedValue => [$opt]);

      return ($optDef->label, $defVal);
   }
   return (undef, undef);
}

#
# Retrieves the value of the option
#
sub get_advoption {
   my ($ao, $key) = @_;
   my ($optDef, $opt) = get_advoption_by_key($ao, $key);
   if (defined($optDef) && defined($opt)) {
      return ($optDef->label, $opt->value);
   }
   return (undef, undef);
}

#
# Sets the value of the option
#
sub set_advoption {
   my ($ao, $key, $set) = @_;
   my ($optDef, $opt) = get_advoption_by_key($ao, $key);
   if (defined($optDef) && defined($opt)) {
      my $valType = get_advoption_type(ref $optDef->optionType);

      my $val = new PrimType($set, $valType);
      $opt->{value} = $val;

      $ao->UpdateOptions(changedValue => [$opt]);
      return $optDef->label;
   } else {
      return undef;
   }
}


sub get_vim_instance {
   my %args = @_;
   my $vim = undef;
   if (exists($args{vim})) {
      $vim = $args{vim};
      if (!ref $vim eq 'Vim') {
         Carp::confess("Argument vim is not a Vim instance.\n");
      }
   }
   else {
      # Retrieving the global session
      $vim = Vim::get_vim();
      unless (defined $vim) {
         Carp::confess("No global session in existence - perhaps need to login first.\n");
      }
   }
   return $vim;
}

1;

############################################################################################
package HostOps;

# ------------------------------------------------------------------------------------------
# Description: Search the inventory tree for all host managed object references that matches
#              the specified filter criteria.  The search begins with the root folder unless
#              the begin_entity parameter is specified.
# Input: subroutine style:  HostOps::get_host_mor(%{vim, begin_entity, filter})
#        where
#           vim           - Vim object instance
#           begin_entity  - starting managed object reference
#           filter        - a hash of one or more name value pair
# Output: a reference to an array host system managed object references
# ------------------------------------------------------------------------------------------
sub get_host_mor{
   my %args = @_;
   my @host_mors;
   my $vim = VIExt::get_vim_instance(%args);
   my $begin_entity = $vim->get_service_content()->rootFolder;
   if (exists($args{begin_entity})) {
      if (defined $args{begin_entity}) {
         $begin_entity = $args{begin_entity};
         my $class = ref $begin_entity;
         if (!($class eq 'ManagedObjectReference')) {
            Carp::confess("begin_entity argument is not of type ManagedObjectReference.\n");
         }
      }
      else {
         Carp::confess("Undefined argument begin_entity.\n");
      }
   }

   my $host_views;
   if (defined $args{filter}) {
      $host_views = Vim::find_entity_views (view_type => 'HostSystem',
                                            begin_entity => $begin_entity,
                                            properties => ['name'],
                                            filter => $args{filter});
   }
   else {
      $host_views = Vim::find_entity_views (view_type => 'HostSystem',
                                            begin_entity => $begin_entity,
                                            properties => ['name']);
   }

   foreach (@$host_views) {
      push @host_mors , $_->{mo_ref};
   }
   return \@host_mors;
}

# -------------------------------------------------------------------------------------------------
# Description: Puts the specified host into maintenance mode.
# Input: subroutine style:  HostOps::enter_maintenance_mode(%{vim, host_mor, timeout, action})
#        where
#           vim           - Vim object instance
#           host_mor      - Host system managed object reference
#           action        - Action for powered on virtual machine [suspend / poweroff]
#           vm_actions    - A hash of powered virtual machine name and actions [suspend / poweroff]
#           timeout       - Time out limit for operation
# Output: Return 1 for successful operation else return fault.
# -------------------------------------------------------------------------------------------------
sub enter_maintenance_mode{
   my %args = @_;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif (! defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");
   }

   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $host_view = $vim->get_view(mo_ref => $host_mo_ref,
                                  properties => ['vm','name']);

   # Retrieving the timeout and action parameters
   my $timeout = -1;
   if (exists($args{timeout})) {
      $timeout = $args{timeout};
   }

   my $action =  undef;
   if (exists ($args{action})) {
      $action = $args{action};
      if ($action ne 'poweroff' && $action ne 'suspend') {
         Carp::confess("Invalid action argument. Possible values are suspend, poweroff.\n");
      }
   }

   my $vm_actions = {};
   if (exists ($args{vm_actions})) {
      $vm_actions = $args{vm_actions};
   }
   else {
      if (!defined $action) {
         $action = 'suspend';
      }
   }

   # Retrieving virtual machine inside host
   my $vms = $host_view->vm;

   # Iterating over the VMs mor array, to check the power status of virtual machines.
   foreach (@$vms) {
      my $returnval = VmOps::get_vm_power_status(vim => $vim,
                                                 vm_mor => $_);
      if ($returnval->{'powerstate'} eq 'poweredOn') {
         my $vmaction;
         if(defined $action) {
            $vmaction = $action;
         }
         else {
            $vmaction = $vm_actions->{$returnval->{'name'}};
            if (!defined $vmaction) {
               Carp::confess("No action specified for VM " . $returnval->{'name'} 
                             . " in hashmap argument vm_actions.\n");
            }
            elsif ($vmaction ne 'poweroff' && $vmaction ne 'suspend') {
               Carp::confess("Invalid action " .$vmaction. " specified for VM " 
                             . $returnval->{'name'} . " in hashmap argument vm_actions.\n");
            }
         }
         if ($vmaction eq 'poweroff') {
            eval { 
               VmOps::poweroff_vm(vim => $vim,
                                  vm_mor => $_);
            };
            if ($@) {
               die $@;
            }
         }
         elsif ($vmaction eq 'suspend') {
            eval {
               VmOps::suspend_vm(vim => $vim,
                                 vm_mor => $_);
            };
            if ($@) {
               die $@;
            }
         }
      }
   }

   # Enter Maintenance Mode Operation
   eval {
      $host_view->EnterMaintenanceMode(timeout => 0);
   };
   if ($@) {
      die $@;
   }
   return 1;
}

# -----------------------------------------------------------------------------------
# Description: Takes the specified host out of maintenance mode.
# Input: subroutine style:  HostOps::exit_maintenance_mode(%{vim, host_mor, timeout})
#        where
#           vim           - Vim object instance
#           host_mor      - Host system managed object reference
#           timeout       - Time out limit for operation
# Output: Return 1 for successful operation Else return fault.
# -----------------------------------------------------------------------------------
sub exit_maintenance_mode{
   my %args = @_;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif (!defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");   
   }

   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $host_view = $vim->get_view(mo_ref => $host_mo_ref,
                                  properties => ['name']);

   # Retrieving the timeout and action parameters
   my $timeout = -1;
   if (exists($args{timeout})) {
      $timeout = $args{timeout};
   }

   # Exit Maintenance Mode Operation
   eval {
      $host_view->ExitMaintenanceMode(timeout => 0);
   };
   if ($@) {
      die $@;
   }
   return 1;
}

# ----------------------------------------------------------------------------------------------
# Description: Reboots a host.
# Input: subroutine style:  HostOps::reboot_host(%{vim, host_mor, force)
#        where
#           vim                       - Vim object instance
#           host_mor                  - Host system managed object reference
#           force                     - Flag to specify whether or not the host should be 
#                                       rebooted regardless of whether it is in maintenance mode
# Output: Return 1 for successful operation Else return fault.
# ----------------------------------------------------------------------------------------------
sub reboot_host {
   my %args = @_;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif (!defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");   
   }

   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $host_view = $vim->get_view(mo_ref => $host_mo_ref,
                                  properties => ['name']);


   # Retrieving the force and enter maintenance mode parameters
   my $force = 0;
   if (exists($args{force})) {
      $force = $args{force};
   }

   if($force != 0 && $force != 1) {
      Carp::confess("Invalid 'force' argument. Must be either '0' or '1'.\n");
   }

   eval {
      $host_view->RebootHost(force => $force);
   };
   if($@) {
      die $@;
   }
   return 1;
}

# ---------------------------------------------------------------------------------------------
# Description: Shutdown a host.
# Input: subroutine style:  HostOps::shutdown_host(%{vim, host_mor, force)
#        where
#           vim                       - Vim object instance
#           host_mor                  - Host system managed object reference
#           force                     - Flag to specify whether or not the host should be 
#                                       rebooted regardless of whether it is in maintenance mode
# Output: Return 1 for successful operation Else return fault.
# ----------------------------------------------------------------------------------------------
sub shutdown_host {
   my %args = @_;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif (!defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");   
   }

   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $host_view = $vim->get_view(mo_ref => $host_mo_ref,
                                  properties => ['name']);

   # Retrieving the force and enter maintenance mode parameters
   my $force = 0;
   if (exists($args{force})) {
      $force = $args{force};
   }

   if($force != 0 && $force != 1) {
      Carp::confess("Invalid 'force' argument. Must be either '0' or '1'.\n");
   }

   eval {
      $host_view->ShutdownHost(force => $force);
   };
   if($@) {
      die $@;
   }
   return 1;
}

# ------------------------------------------------------------------------------
# Description: Retrieves the specific properties of a host
# Input: subroutine style:  HostOps::get_host_info(%{vim, host_mor, properties})
#        where
#           vim             - Vim object instance
#           host_mor        - Host system managed object reference
#           properties      - Array of host properties to be retrieved
# Output: Return 1 for successful operation Else return fault.
# ------------------------------------------------------------------------------
sub get_host_info {
   my %args = @_;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif (!defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");   
   }

   if (!exists($args{properties})) {
      Carp::confess("properties argument is required.\n");
   }
   elsif (!defined $args{properties}) {
      Carp::confess("properties argument is undefined.\n");   
   }

   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $properties = $args{properties};
   my $host_view = $vim->get_view(mo_ref => $host_mo_ref,
                                  properties => $properties);

   return $host_view;
}

# -----------------------------------------------------------------------------------
# Description: Check whether the specified host is in maintenance mode or not.
# Input: subroutine style:  HostOps::check_host_in_maintenance_mode(%{vim, host_mor})
#        where
#           vim           - Vim object instance
#           host_mor      - Host system managed object reference
# Output: Return true if host is maintenance mode else false.
# -----------------------------------------------------------------------------------
sub check_host_in_maintenance_mode {
   my %args = @_;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif (!defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");   
   }

   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $host_view = $vim->get_view(mo_ref => $host_mo_ref,
                                  properties => ['runtime.inMaintenanceMode']);

   my $host_state = $host_view->{'runtime.inMaintenanceMode'};
   return $host_state;
}

# --------------------------------------------------------------------------------
# Description: Returns the list of powered on virtual machine in a specified Host.
# Input: subroutine style:  VmOps::get_vm_power_status(%{vim, vm_mor})
#        where
#           vim           - Vim object instance
#           host_mor      - Host system managed object reference
# Output: a reference to an array powered on virtual machines
# ----------------------------------------------------------------------------------
sub get_list_powered_on_vms {
   my %args = @_;
   my @list_poweredon_vms;

   if (!exists($args{host_mor})) {
      Carp::confess("host_mor argument is required.\n");
   }
   elsif(! defined $args{host_mor}) {
      Carp::confess("host_mor argument is undefined.\n");
   }
   
   my $host_mo_ref = $args{host_mor};
   my $vim = VIExt::get_vim_instance(%args);
   my $host_view = $vim->get_view(mo_ref => $host_mo_ref);

   my $vms = $host_view->vm;

   foreach (@$vms) {
      my $returnval = VmOps::get_vm_power_status(vim => $vim,
                                                 vm_mor => $_);
      if ($returnval->{'powerstate'} eq 'poweredOn') {
         my $vm_name = $returnval->{'name'};
         push @list_poweredon_vms, $vm_name;
      }
   }
   return \@list_poweredon_vms;
}

1;
##################################################################################
package VmOps;

# ----------------------------------------------------------------------------------
# Description: Returns the power state of specified virtual machine.
# Input: subroutine style:  VmOps::get_vm_power_status(%{vim, vm_mor})
#        where
#           vim           - Vim object instance
#           vm_mor        - Virtual machine managed object reference
# Output: Return power status of virtual machine [poweredOff, poweredOn, suspended].
# ----------------------------------------------------------------------------------
sub get_vm_power_status {
   my %args = @_;

   # Retrieving the parameters
   if (!exists($args{vm_mor})) {
      Carp::confess("vm_mor argument is required.\n");
   }
   elsif (!defined $args{vm_mor}) {
      Carp::confess("vm_mor argument is undefined.\n");   
   }

   my $vm_mo_ref = $args{vm_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $vm_view = $vim->get_view(mo_ref => $vm_mo_ref,
                                properties => ['name', 'runtime.powerState']);
   my %returnval;
   $returnval{'name'}= $vm_view->name;
   $returnval{'powerstate'}= $vm_view->{'runtime.powerState'}->val;
   return \%returnval;
}

# ------------------------------------------------------------------
# Description: Power Off the virtual machine.
# Input: subroutine style:  VmOps::poweroff_vm(%{vim, vm_mor})
#        where
#           vim           - Vim object instance
#           vm_mor        - Virtual machine managed object reference
# Output: Return 1 for successful operation else return fault.
# ------------------------------------------------------------------
sub poweroff_vm {
   my %args = @_;

   # Retrieving the parameters
   if (! exists($args{vm_mor})) {
      Carp::confess("vm_mor argument is required.\n");
   }
   elsif (! defined $args{vm_mor}) {
      Carp::confess("vm_mor argument is undefined.\n");   
   }

   my $vm_mo_ref = $args{vm_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $vm_view = $vim->get_view(mo_ref => $vm_mo_ref);
   eval {
      $vm_view->PowerOffVM();
   };
   if ($@) { 
      die $@;
   }
   return 1;
}

# ------------------------------------------------------------------
# Description: Suspend the specified virtual machine.
# Input: subroutine style:  VmOps::suspend_vm(%{vim, vm_mor})
#        where
#           vim           - Vim object instance
#           vm_mor        - Virtual machine managed object reference
# Output: Return 1 for successful operation else return fault.
# ------------------------------------------------------------------
sub suspend_vm {
   my %args = @_;

   # Retrieving the parameters
   if (! exists($args{vm_mor})) {
      Carp::confess("vm_mor argument is required.\n");
   }
   elsif (! defined $args{vm_mor}) {
      Carp::confess("vm_mor argument is undefined.\n");   
   }

   my $vm_mo_ref = $args{vm_mor};
   my $vim = VIExt::get_vim_instance(%args);

   my $vm_view = $vim->get_view(mo_ref => $vm_mo_ref);
   eval {
      $vm_view->SuspendVM();
   };
   if ($@) { 
      die $@;
   }
   return 1;
}
1;