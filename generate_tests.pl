#!/usr/bin/perl
use strict;
use warnings;
our %vcenter = (
	'type' => 'datacenter',
	'flag' => '-D',
	'name' => 'vmware-plugin-dev-vcenter.dev.op5.com',
	'user' => 'devtest',
	'password' => 'monitor'
);
our %esx = (
	'type' => 'host',
	'flag' => '-H',
	'name' => 'vmware-plugin-dev-01.dev.op5.com',
	'user' => 'root',
	'password' => 'monitor'
);
sub build_command
{
	my ($target, $command, $subcommand) = @_;
	my $command_str = '';
	$command_str .= "./check_vmware_api.pl $target->{flag} $target->{name} -u $target->{user} -p $target->{password} -l ${command}";
	$command_str .= " -s ${subcommand}" if defined($subcommand);
	$command_str .= " --generate_test /tmp/$target->{type}_${command}";
	$subcommand =~ s/\//_/ if defined($subcommand);
	$command_str .= defined($subcommand) ? "_${subcommand}" :"_all";
	$command_str . ".dat";
}

#map of host & datacenter commands
my %command_map = (
	'host' => {
		'cpu' => ['usage', 'usagemhz', undef],
		'mem' => ['usage', 'usagemb', 'swap', 'overhead', 'overall', 'memctl', undef],
		'net' => ['usage', 'receive', 'send', 'nic', undef],
		'io' => ['aborted', 'resets', 'read', 'write', 'kernel', 'device', 'queue', undef],
		'vmfs' => [undef],
		'runtime' => ['con', 'health', 'storagehealth', 'temperature', 'sensor', 'maintenance', 'list', 'status', 'issues', undef],
		'service' => [undef],
		'storage' => ['adapter', 'lun', 'path', undef],
		'device' => ['cd/dvd']
	},
	'datacenter' => {
		'cpu' => ['usage', 'usagemhz', undef],
		'mem' => ['usage', 'usagemb', 'swap', 'overhead', 'overall', 'memctl', undef],
		'net' => ['usage', 'receive', 'send', undef],
		'io' => ['aborted', 'resets', 'read', 'write', 'kernel', 'device', 'queue', undef],
		'vmfs' => [undef],
		'runtime' => ['list', 'listhost', 'listcluster', 'tools', 'status', 'issues', undef],
		'recommendations' => [undef]
	}
);

my @commands = ();
foreach my $type ( keys %command_map ) {
	foreach my $command ( keys %{$command_map{$type}} ) {
		foreach my $subcommand (@{$command_map{$type}{$command}}) {
			my $target = $type eq 'host' ? \%esx : \%vcenter;
			push @commands,
				build_command($target, $command, $subcommand);
		}
	}
}

foreach my $cmd (@commands) {
	system $cmd;
}
