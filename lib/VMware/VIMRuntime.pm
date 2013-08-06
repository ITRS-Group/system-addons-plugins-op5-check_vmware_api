package VIMRuntime;

use 5.006001;
use strict;
use warnings;

use VMware::VICommon;
use Carp qw(confess croak);

my $vmware_lib_dir = $INC{'VMware/VIMRuntime.pm'}; 
$vmware_lib_dir =~ s#(.*)/.*$#$1#; 

our %stub_class;

sub initialize {
   my ($self, $server_version) = @_;
   my $vim_stub = undef;
   my $vim_runtime = undef;
   
   if(defined($server_version) and $server_version eq '25') {
      $vim_stub = "$vmware_lib_dir/VIM25Stub.pm";
      $vim_runtime = "$vmware_lib_dir/VIM25Runtime.pm";
   }
   else {
      $vim_stub = "$vmware_lib_dir/VIM2Stub.pm";
      $vim_runtime = "$vmware_lib_dir/VIM2Runtime.pm";
   }

   local $/;

   open STUB, $vim_stub or die $!; 
   my @stub = split /\n####+?\n/, <STUB>;
   close STUB or die $!;

   open RUNTIME, $vim_runtime or die $!;
   my @runtime = split /\n####+?\n/, <RUNTIME>; 
   close RUNTIME or die $!; 

   push @stub, @runtime;
   for (@stub) {
      my ($package) = /\bpackage\s+(\w+)/;
      $stub_class{$package} = $_ if defined $package; 
   }
}

sub load {
   my $package = shift; 
   {
      no strict 'refs'; 
      return 0 if keys %{"$package\::"}; 
   }
   die "Can't load class '$package'" unless exists $stub_class{$package};
   my ($isa) = $stub_class{$package} =~ /\@ISA\s*=\s*qw\((.*?)\)/;
   $isa = '' unless defined $isa;
   my @isa = split /\s+/, $isa;
   for (@isa) {
      load($_);
   }
   eval $stub_class{$package};
   die $@ if $@;
   return 1;
}

sub make_get_set {
   my $class = shift;
   for my $member (@_) {
      no strict 'refs';      
      *{$class . '::' . $member} = sub {
         my $package = shift;
         if (@_) {
            return $package->{$member} = shift;
         } else {
            return $package->{$member};
         }
      }
   }
}

sub UNIVERSAL::AUTOLOAD {
   my ($package, $sub) = $UNIVERSAL::AUTOLOAD =~ /^(.*)::(.*)/;
   return if $sub eq 'DESTROY';       
   unless (load $package) {
      croak "Undefined subroutine &$UNIVERSAL::AUTOLOAD called";
   };
   
   if ($package->can($sub)) {
      goto $package->can($sub);
   } else {
      use Carp;
      croak "Undefined subroutine &$UNIVERSAL::AUTOLOAD called";
   }   
}
1;
