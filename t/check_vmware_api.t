package CheckVMwareAPI;
use LWP::UserAgent;
use Test::More tests => 3;
use Test::MockObject;
use VMware::VICommon;
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

*Vim::query_api_supported = sub {
	my %r;
	$r{"supported"}  =1;
	return %r;
};
my $server_version_response = '<?xml version="1.0" encoding="UTF-8" ?>
<!--
   Copyright 2005-2012 VMware, Inc.  All rights reserved.
-->
<definitions targetNamespace="urn:vim25Service"
   xmlns="http://schemas.xmlsoap.org/wsdl/"
   xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
   xmlns:interface="urn:vim25"
>
   <import location="vim.wsdl" namespace="urn:vim25" />
   <service name="VimService">
      <port binding="interface:VimBinding" name="VimPort">
         <soap:address location="https://localhost/sdk/vimService" />
      </port>
   </service>
</definitions>
';

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

sub load_script
{
	my $script_name = shift;
	my @response_strings;
	my $r;
	open FILE, "./t/series/${script_name}.dat" or die $!;
	while( <FILE> ) {
		if ($_ =~ /^!/) {
			push @response_strings, $r;
			$r = '';
		}
		else {
			$r .= $_;
		}
	}

	return response_series(@response_strings);
}

sub response_series
{
	my @responses;
	my $c;
	foreach $c (@_) {
		push @responses, new_response($c);
	}
	return @responses;
}
sub new_response
{
	my $content = shift;
	my $response = HTTP::Response->new(200);
	$response->content($content);
	return $response;
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

$agent_mock->set_series('request',
	response_series('Connection refused')
);
ok(run_cmd('-H dummyhost -u devtest -p devtest -l net -s usage') == 2, "Connection refused returns CRITICAL");


my @responses = (new_response($server_version_response));
push @responses, load_script('net_usage');
$agent_mock->set_series('request', @responses);

ok(run_cmd('-H dummyhost -u devtest -p devtest -l net -s usage') == 0, "net/usage working");
