package CheckVMwareAPI;
use Test::More tests => 1;
use strict;
my $DEBUG;
BEGIN {
	#global override of exit(), since the plugin uses Nagios::Plugin::nagios_exit all over the place.
	*CORE::GLOBAL::exit = sub {
		warn 'Suppressing "exit" called with ' . shift if $DEBUG;
		1
	};
}
require_ok( 'check_vmware_api.pl' );

1;
