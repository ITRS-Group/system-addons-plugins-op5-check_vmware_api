package CheckVMwareAPI;
use LWP::UserAgent;
use Test::More tests => 2;
use Test::MockObject;
use subs qw(exit);
use strict;
my $DEBUG;
BEGIN {
	*CORE::GLOBAL::exit  = sub {
		my $code = shift;
		if ( $code != 0 ) {
			warn 'die()ing instead of exiting for exit code ${code}' if $DEBUG;
		}
		die( $code );
	}
}
my $error;
my $agent_mock = Test::MockObject->new();
$agent_mock->set_true('cookie_jar');
$agent_mock->set_true('protocols_allowed');
$agent_mock->set_true('conn_cache');

require_ok('check_vmware_api.pl');

$agent_mock->mock('request', sub($) {
		return 'Connection refused';
	});

*LWP::UserAgent::new = sub {
	return $agent_mock;
};
#check_vmware_api.pl -H dummyhost -u monitor -p monitor -l net -s usage;
@ARGV = split(/ /, '-H dummyhost -u monitor -p monitor -l net -s usage');
eval {
	CheckVMwareAPI->main;
};
$error = $@;
ok($@ == 2, "Connection refused returns CRITICAL");
1;
