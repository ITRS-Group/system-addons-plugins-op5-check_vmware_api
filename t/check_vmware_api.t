package CheckVMwareAPI;
use LWP::UserAgent;
use Test::More tests => 5;
use Test::MockObject;
use VMware::VICommon;
use subs qw(exit);
use strict;
my $DEBUG;

BEGIN {
	*CORE::GLOBAL::exit  = sub {
		my $code = shift;
		if ( $code != 0 ) {
			warn "die()ing instead of exiting for exit code ${code}" if $DEBUG;
		}
		die( $code );
	}
}

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
	my @saved_argv = @ARGV;
	my $args = shift;
	my %ret;

	# setup environment
	@ARGV = split(/ /, $args);
	my $output = '';
	open OUTPUT, '>', \$output or die "Can't open OUTPUT: $!";

	eval {
		select( OUTPUT );
		CheckVMwareAPI->main;
	};

	# reset environment
	select(STDOUT);
	@ARGV = @saved_argv;
	$ret{'status'} = $@;
	$ret{'stdout'} = $output;
	%ret;
}

sub load_script
{
	my $script_name = shift;
	my @response_strings = ();
	my $r = '';
	my $ignore = 0;
	open FILE, "./t/series/${script_name}.dat" or die $!;
	while( <FILE> ) {
		if ($_ =~ /^<definitions targetNamespace=.*/) {
			$ignore = 1;
		}
		elsif ($_ =~ /^!/) {
			push @response_strings, $r if !$ignore;
			$r = '';
			$ignore = 0;
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

my %ret = run_cmd('-H dummyhost -u devtest -p devtest -l net -s usage');
ok($ret{"status"} == 2, "Connection refused returns CRITICAL");
like($ret{"stdout"}, qr/CRITICAL.*Connection refused/, "Connection refused returns CRITICAL (output verified)");


my @responses = (new_response($server_version_response));
push @responses, load_script('net_usage');
$agent_mock->set_series('request', @responses);
%ret = run_cmd('-H dummyhost -u devtest -p devtest -l net -s usage');
ok($ret{"status"} == 0, "net/usage has OK exit status without thresholds");
like($ret{"stdout"}, qr/OK - net usage=158.00 KBps/, "net/usage output looks like expected");
