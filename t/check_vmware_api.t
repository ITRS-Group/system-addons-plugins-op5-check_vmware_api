package CheckVMwareAPI;
use LWP::UserAgent;
use Test::More;
use Test::MockObject;
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
	my @response_strings = ();
	my $buf = '';
	# this negative look-ahead will never match
	# when used as a pattern (which is good, since
	# we don't have any output to match against if
	# it's not replaced). In other words, if we try
	# to match against uninitialized output, we fail
	# horribly.
	my $output = '(?!)';
	my $status = 0;
	my $ignore = 0;
	open FILE, "./t/series/" . shift . ".dat" or die $!;
	while( <FILE> ) {
		if (/^<definitions targetNamespace=.*/) {
			$ignore = 1;
		}
		elsif (/^!/) {
			push @response_strings, substr $buf, 0, -1 if !$ignore;
			$buf = '';
			$ignore = 0;
		}
		elsif (/^#/) {
			#skip '#'
			$output = substr $_, 1;
			#trim
			$output =~ s/^\s+//;
			$output =~ s/\s+$//;
		}
		elsif (/^-(\d+)/) {
			$status = $1;
		}
		else {
			$buf .= $_;
		}
	}
	return {
		"responses" => [response_series(@response_strings)],
		"output" => $output,
		"status" => $status,
	};
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

sub run_scripts
{
	my ($agent, $directory) = @_;
	diag "loading test scripts from ${directory}";
	opendir (DIR, $directory) or die $!;
	while ( readdir(DIR) ) {
		if (/([a-zA-Z0-9]+)_([a-zA-Z0-9]+)_(\w+).dat/) {
			diag "running ${_} ...";
			my ($target, $command, $subcommand) = ($1, $2, $3);
			my $script_name = "${target}_${command}_${subcommand}";
			run_script($agent, $script_name, $target, ${command}, ${subcommand});
		}
		else {
			diag "skipping '${_}' ...";

		}
	}
}
sub run_script
{
	my $agent = shift;
	my $script_name = shift;
	my $target = shift;
	my $command = shift;
	my $subcommand = shift;
	my $script = load_script($script_name);
	my $cmd_str = '';
	$subcommand =~ s/_/\// if defined($subcommand);
	$agent->set_series('request', @{$script->{responses}});
	$cmd_str .= $target eq 'datacenter' ? '-D dummycenter ' :'-H dummyhost ';
	if ($subcommand eq 'all') {
		$cmd_str .= "-u devtest -p devtest -l ${command}";
	}
	else {
		$cmd_str .= "-u devtest -p devtest -l ${command} -s ${subcommand}";
	}
	diag ("using args '${cmd_str}' ");
	my %ret = run_cmd($cmd_str);
	ok($ret{"status"} == $script->{status}, "${script_name} has the expected ($script->{status}) exit status without thresholds");
	like($ret{"stdout"}, qr/\Q$script->{output}/, "${script_name} output looks like expected");
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
	(
		#we need to send the version response only once, on initialization
		new_response($server_version_response),
		new_response('Connection refused')
	)
);
my %ret = run_cmd('-H dummyhost -u devtest -p devtest -l net -s usage');
ok($ret{"status"} == 2, "Connection refused returns CRITICAL");
like($ret{"stdout"}, qr/CRITICAL.*Connection refused/, "Connection refused returns CRITICAL (output verified)");

%ret = run_cmd('-H dummyhost -u devtest -p devtest -l foo -s bar');
ok($ret{"status"} == 2, "Unknown host command returns CRITICAL");
like($ret{"stdout"}, qr/CRITICAL.*Unknown HOST command/, "Output tells us we have supplied an unknown host command");

%ret = run_cmd('-D dummycenter -u devtest -p devtest -l foo -s bar');
ok($ret{"status"} == 2, "Unknown datacenter command returns CRITICAL");
like($ret{"stdout"}, qr/CRITICAL.*Unknown DC command/, "Output tells us we have supplied an unknown DC command");

diag('Running conservative regression tests ...');
run_scripts($agent_mock, './t/series');
done_testing;
