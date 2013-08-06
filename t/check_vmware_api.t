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
sub run_cmd
{
	my $ret;
	my @saved_argv = @ARGV;
	my $args = shift;
	@ARGV = split(/ /, $args);
	eval {
		CheckVMwareAPI->main;
	};
	$ret = $@;
	@ARGV = @saved_argv;
	$ret;
}

my $agent_mock = Test::MockObject->new();
# The User Agent is the object which takes care of the actual communication
# with the VMware web service. By mocking it out, we're able to return whatever
# data we choose to. This makes for a pretty flexible testing approach.
$agent_mock->fake_new('LWP::UserAgent');
$agent_mock->set_true('cookie_jar');
$agent_mock->set_true('protocols_allowed');
$agent_mock->set_true('conn_cache');

require_ok('check_vmware_api.pl');

$agent_mock->mock('request', sub($) {
		return 'Connection refused';
	});
#check_vmware_api.pl -H dummyhost -u monitor -p monitor -l net -s usage;
ok(run_cmd('-H dummyhost -u monitor -p monitor -l net -s usage') == 2, "Connection refused returns CRITICAL");
1;
