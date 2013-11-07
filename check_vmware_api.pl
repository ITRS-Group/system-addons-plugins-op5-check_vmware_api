#!/usr/bin/perl -w
#
# Nagios plugin to monitor VMware ESX and vSphere servers
#
# License: GPL
# Copyright (c) 2008-2013 op5 AB
# Author: Kostyantyn Hushchyn and op5 <op5-users@lists.op5.com>
#
# Contributors:
#
# Patrick Müller, Jeremy Martin, Eric Jonsson, stumpr,
# John Cavanaugh, Libor Klepac, maikmayers, Steffen Poulsen,
# Mark Elliott, simeg, sebastien.prudhomme, Raphael Schitz,
# Mattias Bergsten
#
# For direct contact with any of the op5 developers, send an email to
# op5-users@lists.op5.com
#
# Discussions are directed to the mailing list op5-users@lists.op5.com,
# see http://lists.op5.com/mailman/listinfo/op5-users
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

package CheckVMwareAPI;
use strict;
use warnings;
use vars qw($PROGNAME $VERSION $output $values $result $defperfargs);
use Nagios::Plugin::Functions qw(%STATUS_TEXT);
use Nagios::Plugin;
use File::Basename;
use HTTP::Date;
use Data::Dumper qw(Dumper);
my $perl_module_instructions="
Download the latest version of the vSphere SDK for Perl from VMware.
In this example we use VMware-vSphere-Perl-SDK-5.1.0-780721.x86_64.tar.gz,
but the instructions should apply to other versions as well.

You may need to install additional packages and Perl modules on your server,
see http://www.op5.com/how-to/how-to-install-vmware-vsphere-sdk-perl-5-1/ for
more information and package names for op5 APS / CentOS 6 / RHEL 6.

Upload the .tar.gz file to your op5 Monitor server's /root dir and execute:

    cd /root
    tar xvzf VMware-vSphere-Perl-SDK-5.1.0-780721.x86_64.tar.gz
    cd vmware-vsphere-cli-distrib/
    ./vmware-install.pl

Follow the on screen instructions, described below:

  \"Creating a new vSphere CLI installer database using the tar4 format.

  Installing vSphere CLI 5.1.0 build-780721 for Linux.

  You must read and accept the vSphere CLI End User License Agreement to
  continue.
  Press enter to display it.\"

    <ENTER>

  \"Read through the License Agreement\"
  \"Do you accept? (yes/no)

    yes

  \"In which directory do you want to install the executable files? [/usr/bin]\"

    <ENTER>

  \"Please wait while copying vSphere CLI files...

  The installation of vSphere CLI 5.1.0 build-780721 for Linux completed
  successfully. You can decide to remove this software from your system at any
  time by invoking the following command:
  \"/usr/bin/vmware-uninstall-vSphere-CLI.pl\".

  This installer has successfully installed both vSphere CLI and the vSphere SDK
  for Perl.

  The following Perl modules were found on the system but may be too old to work 
  with vSphere CLI:

  Compress::Zlib 2.037 or newer 
  Compress::Raw::Zlib 2.037 or newer 
  version 0.78 or newer 
  IO::Compress::Base 2.037 or newer 
  IO::Compress::Zlib::Constants 2.037 or newer 
  LWP::Protocol::https 5.805 or newer 

  Enjoy,

  --the VMware team\"

Note: None of the Perl modules mentioned as \"may be too old\" are needed for check_vmware_api to work.
";

sub main {
	$PROGNAME = basename($0);
	$VERSION = '0.7.1';

	my $np = Nagios::Plugin->new(
		usage => "Usage: %s -D <data_center> | -H <host_name> [ -C <cluster_name> ] [ -N <vm_name> ]\n"
		. "    -u <user> -p <pass> | -f <authfile>\n"
		. "    -l <command> [ -s <subcommand> ] [ -T <timeshift> ] [ -i <interval> ]\n"
		. "    [ -x <black_list> ] [ -o <additional_options> ]\n"
		. "    [ -t <timeout> ] [ -w <warn_range> ] [ -c <crit_range> ]\n"
		. '    [ -V ] [ -h ]',
		version => $VERSION,
		plugin  => $PROGNAME,
		shortname => uc($PROGNAME),
		blurb => 'VMware ESX/vSphere plugin',
		extra   => "Supported commands(^ - blank or not specified parameter, o - options, T - timeshift value, b - blacklist) :\n"
		. "    VM specific :\n"
		. "        * cpu - shows cpu info\n"
		. "            + usage - CPU usage in percentage\n"
		. "            + usagemhz - CPU usage in MHz\n"
		. "            + wait - CPU wait time in ms\n"
		. "            + ready - CPU ready time in ms\n"
		. "            ^ all cpu info(no thresholds)\n"
		. "        * mem - shows mem info\n"
		. "            + usage - mem usage in percentage\n"
		. "            + usagemb - mem usage in MB\n"
		. "            + swap - swap mem usage in MB\n"
		. "            + swapin - swapin mem usage in MB\n"
		. "            + swapout - swapout mem usage in MB\n"
		. "            + overhead - additional mem used by VM Server in MB\n"
		. "            + overall - overall mem used by VM Server in MB\n"
		. "            + active - active mem usage in MB\n"
		. "            + memctl - mem used by VM memory control driver(vmmemctl) that controls ballooning\n"
		. "            ^ all mem info(except overall and no thresholds)\n"
		. "        * net - shows net info\n"
		. "            + usage - overall network usage in KBps(Kilobytes per Second)\n"
		. "            + receive - receive in KBps(Kilobytes per Second)\n"
		. "            + send - send in KBps(Kilobytes per Second)\n"
		. "            ^ all net info(except usage and no thresholds)\n"
		. "        * io - shows disk I/O info\n"
		. "            + usage - overall disk usage in MB/s\n"
		. "            + read - read latency in ms (totalReadLatency.average)\n"
		. "            + write - write latency in ms (totalWriteLatency.average)\n"
		. "            ^ all disk io info(no thresholds)\n"
		. "        * runtime - shows runtime info\n"
		. "            + con - connection state\n"
		. "            + cpu - allocated CPU in MHz\n"
		. "            + mem - allocated mem in MB\n"
		. "            + state - virtual machine state (UP, DOWN, SUSPENDED)\n"
		. "            + status - overall object status (gray/green/red/yellow)\n"
		. "            + consoleconnections - console connections to VM\n"
		. "            + guest - guest OS status, needs VMware Tools\n"
		. "            + tools - VMWare Tools status\n"
		. "            + issues - all issues for the host\n"
		. "            ^ all runtime info(except con and no thresholds)\n"
		. "    Host specific :\n"
		. "        * cpu - shows cpu info\n"
		. "            + usage - CPU usage in percentage\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            + usagemhz - CPU usage in MHz\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            ^ all cpu info\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "        * mem - shows mem info\n"
		. "            + usage - mem usage in percentage\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            + usagemb - mem usage in MB\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            + swap - swap mem usage in MB\n"
		. "                o listvm - turn on/off output list of swapping VM's\n"
		. "            + overhead - additional mem used by VM Server in MB\n"
		. "            + overall - overall mem used by VM Server in MB\n"
		. "            + memctl - mem used by VM memory control driver(vmmemctl) that controls ballooning\n"
		. "                o listvm - turn on/off output list of ballooning VM's\n"
		. "            ^ all mem info(except overall and no thresholds)\n"
		. "        * net - shows net info\n"
		. "            + usage - overall network usage in KBps(Kilobytes per Second)\n"
		. "            + receive - receive in KBps(Kilobytes per Second)\n"
		. "            + send - send in KBps(Kilobytes per Second)\n"
		. "            + nic - makes sure all active NICs are plugged in\n"
		. "            ^ all net info(except usage and no thresholds)\n"
		. "        * io - shows disk io info\n"
		. "            + aborted - aborted commands count\n"
		. "            + resets - bus resets count\n"
		. "            + read - read latency in ms (totalReadLatency.average)\n"
		. "            + write - write latency in ms (totalWriteLatency.average)\n"
		. "            + kernel - kernel latency in ms\n"
		. "            + device - device latency in ms\n"
		. "            + queue - queue latency in ms\n"
		. "            ^ all disk io info\n"
		. "        * vmfs - shows Datastore info\n"
		. "            + (name) - free space info for datastore with name (name)\n"
		. "                o used - output used space instead of free\n"
		. "                o breif - list only alerting volumes\n"
		. "                o regexp - whether to treat name as regexp\n"
		. "                o blacklistregexp - whether to treat blacklist as regexp\n"
		. "                b - blacklist VMFS's\n"
		. "                T (value) - timeshift to detemine if we need to refresh\n"
		. "            ^ all datastore info\n"
		. "                o used - output used space instead of free\n"
		. "                o breif - list only alerting volumes\n"
		. "                o blacklistregexp - whether to treat blacklist as regexp\n"
		. "                b - blacklist VMFS's\n"
		. "                T (value) - timeshift to detemine if we need to refresh\n"
		. "        * runtime - shows runtime info\n"
		. "            + con - connection state\n"
		. "            + health - checks cpu/storage/memory/sensor status and propagates worst state\n"
		. "                o listitems - list all available sensors(use for listing purpose only)\n"
		. "                o blackregexpflag - whether to treat blacklist as regexp\n"
		. "                b - blacklist status objects\n"
		. "            + storagehealth - storage status check\n"
		. "                o blackregexpflag - whether to treat blacklist as regexp\n"
		. "                b - blacklist status objects\n"
		. "            + temperature - temperature sensors\n"
		. "                o blackregexpflag - whether to treat blacklist as regexp\n"
		. "                b - blacklist status objects\n"
		. "            + sensor - threshold specified sensor\n"
		. "            + maintenance - shows whether host is in maintenance mode\n"
		. "            + list(vm) - list of VMWare machines and their statuses\n"
		. "            + status - overall object status (gray/green/red/yellow)\n"
		. "            + issues - all issues for the host\n"
		. "                b - blacklist issues\n"
		. "            ^ all runtime info(health, storagehealth, temperature and sensor are represented as one value and no thresholds)\n"
		. "        * service - shows Host service info\n"
		. "            + (names) - check the state of one or several services specified by (names), syntax for (names):<service1>,<service2>,...,<serviceN>\n"
		. "            ^ show all services\n"
		. "        * storage - shows Host storage info\n"
		. "            + adapter - list bus adapters\n"
		. "                b - blacklist adapters\n"
		. "            + lun - list SCSI logical units\n"
		. "                b - blacklist LUN's\n"
		. "            + path - list logical unit paths\n"
		. "                b - blacklist paths\n"
		. "            ^ show all storage info\n"
		. "        * uptime - shows Host uptime\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "        * device - shows Host specific device info\n"
		. "            + cd/dvd - list vm's with attached cd/dvd drives\n"
		. "                o listall - list all available devices(use for listing purpose only)\n"
		. "    DC specific :\n"
		. "        * cpu - shows cpu info\n"
		. "            + usage - CPU usage in percentage\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            + usagemhz - CPU usage in MHz\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            ^ all cpu info\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "        * mem - shows mem info\n"
		. "            + usage - mem usage in percentage\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            + usagemb - mem usage in MB\n"
		. "                o quickstats - switch for query either PerfCounter values or Runtime info\n"
		. "            + swap - swap mem usage in MB\n"
		. "            + overhead - additional mem used by VM Server in MB\n"
		. "            + overall - overall mem used by VM Server in MB\n"
		. "            + memctl - mem used by VM memory control driver(vmmemctl) that controls ballooning\n"
		. "            ^ all mem info(except overall and no thresholds)\n"
		. "        * net - shows net info\n"
		. "            + usage - overall network usage in KBps(Kilobytes per Second)\n"
		. "            + receive - receive in KBps(Kilobytes per Second)\n"
		. "            + send - send in KBps(Kilobytes per Second)\n"
		. "            ^ all net info(except usage and no thresholds)\n"
		. "        * io - shows disk io info\n"
		. "            + aborted - aborted commands count\n"
		. "            + resets - bus resets count\n"
		. "            + read - read latency in ms (totalReadLatency.average)\n"
		. "            + write - write latency in ms (totalWriteLatency.average)\n"
		. "            + kernel - kernel latency in ms\n"
		. "            + device - device latency in ms\n"
		. "            + queue - queue latency in ms\n"
		. "            ^ all disk io info\n"
		. "        * vmfs - shows Datastore info\n"
		. "            + (name) - free space info for datastore with name (name)\n"
		. "                o used - output used space instead of free\n"
		. "                o breif - list only alerting volumes\n"
		. "                o regexp - whether to treat name as regexp\n"
		. "                o blacklistregexp - whether to treat blacklist as regexp\n"
		. "                b - blacklist VMFS's\n"
		. "                T (value) - timeshift to detemine if we need to refresh\n"
		. "            ^ all datastore info\n"
		. "                o used - output used space instead of free\n"
		. "                o breif - list only alerting volumes\n"
		. "                o blacklistregexp - whether to treat blacklist as regexp\n"
		. "                b - blacklist VMFS's\n"
		. "                T (value) - timeshift to detemine if we need to refresh\n"
		. "        * runtime - shows runtime info\n"
		. "            + list(vm) - list of VMWare machines and their statuses\n"
		. "            + listhost - list of VMWare esx host servers and their statuses\n"
		. "            + listcluster - list of VMWare clusters and their statuses\n"
		. "            + tools - VMWare Tools status\n"
		. "                b - blacklist VM's\n"
		. "            + status - overall object status (gray/green/red/yellow)\n"
		. "            + issues - all issues for the host\n"
		. "                b - blacklist issues\n"
		. "            ^ all runtime info(except cluster and tools and no thresholds)\n"
		. "        * recommendations - shows recommendations for cluster\n"
		. "            + (name) - recommendations for cluster with name (name)\n"
		. "            ^ all clusters recommendations\n"
		. "    Cluster specific :\n"
		. "        * cpu - shows cpu info\n"
		. "            + usage - CPU usage in percentage\n"
		. "            + usagemhz - CPU usage in MHz\n"
		. "            ^ all cpu info\n"
		. "        * mem - shows mem info\n"
		. "            + usage - mem usage in percentage\n"
		. "            + usagemb - mem usage in MB\n"
		. "            + swap - swap mem usage in MB\n"
		. "                o listvm - turn on/off output list of swapping VM's\n"
		. "            + memctl - mem used by VM memory control driver(vmmemctl) that controls ballooning\n"
		. "                o listvm - turn on/off output list of ballooning VM's\n"
		. "            ^ all mem info(plus overhead and no thresholds)\n"
		. "        * cluster - shows cluster services info\n"
		. "            + effectivecpu - total available cpu resources of all hosts within cluster\n"
		. "            + effectivemem - total amount of machine memory of all hosts in the cluster\n"
		. "            + failover - VMWare HA number of failures that can be tolerated\n"
		. "            + cpufainess - fairness of distributed cpu resource allocation\n"
		. "            + memfainess - fairness of distributed mem resource allocation\n"
		. "            ^ only effectivecpu and effectivemem values for cluster services\n"
		. "        * runtime - shows runtime info\n"
		. "            + list(vm) - list of VMWare machines in cluster and their statuses\n"
		. "            + listhost - list of VMWare esx host servers in cluster and their statuses\n"
		. "            + status - overall cluster status (gray/green/red/yellow)\n"
		. "            + issues - all issues for the cluster\n"
		. "                b - blacklist issues\n"
		. "            ^ all cluster runtime info\n"
		. "        * vmfs - shows Datastore info\n"
		. "            + (name) - free space info for datastore with name (name)\n"
		. "                o used - output used space instead of free\n"
		. "                o breif - list only alerting volumes\n"
		. "                o regexp - whether to treat name as regexp\n"
		. "                o blacklistregexp - whether to treat blacklist as regexp\n"
		. "                b - blacklist VMFS's\n"
		. "                T (value) - timeshift to detemine if we need to refresh\n"
		. "            ^ all datastore info\n"
		. "                o used - output used space instead of free\n"
		. "                o breif - list only alerting volumes\n"
		. "                o blacklistregexp - whether to treat blacklist as regexp\n"
		. "                b - blacklist VMFS's\n"
		. "                T (value) - timeshift to detemine if we need to refresh\n"
		. "\n\nCopyright (c) 2008-2013 op5",
		timeout => 30,
	);

	$np->add_arg(
		spec => 'host|H=s',
		help => "-H, --host=<hostname>\n"
		. '   ESX or ESXi hostname.',
		required => 0,
	);

	$np->add_arg(
		spec => 'cluster|C=s',
		help => "-C, --cluster=<clustername>\n"
		. '   ESX or ESXi clustername.',
		required => 0,
	);

	$np->add_arg(
		spec => 'datacenter|D=s',
		help => "-D, --datacenter=<DCname>\n"
		. '   Datacenter hostname.',
		required => 0,
	);

	$np->add_arg(
		spec => 'name|N=s',
		help => "-N, --name=<vmname>\n"
		. '   Virtual machine name.',
		required => 0,
	);

	$np->add_arg(
		spec => 'username|u=s',
		help => "-u, --username=<username>\n"
		. '   Username to connect with.',
		required => 0,
	);

	$np->add_arg(
		spec => 'password|p=s',
		help => "-p, --password=<password>\n"
		. '   Password to use with the username.',
		required => 0,
	);

	$np->add_arg(
		spec => 'authfile|f=s',
		help => "-f, --authfile=<path>\n"
		. "   Authentication file with login and password. File syntax :\n"
		. "   username=<login>\n"
		. '   password=<password>',
		required => 0,
	);

	$np->add_arg(
		spec => 'warning|w=s',
		help => "-w, --warning=THRESHOLD\n"
		. "   Warning threshold. See\n"
		. "   http://nagiosplug.sourceforge.net/developer-guidelines.html#THRESHOLDFORMAT\n"
		. '   for the threshold format. By default, no threshold is set.',
		required => 0,
	);

	$np->add_arg(
		spec => 'critical|c=s',
		help => "-c, --critical=THRESHOLD\n"
		. "   Critical threshold. See\n"
		. "   http://nagiosplug.sourceforge.net/developer-guidelines.html#THRESHOLDFORMAT\n"
		. '   for the threshold format. By default, no threshold is set.',
		required => 0,
	);

	$np->add_arg(
		spec => 'command|l=s',
		help => "-l, --command=COMMAND\n"
		. '   Specify command type (CPU, MEM, NET, IO, VMFS, RUNTIME, ...)',
		required => 1,
	);

	$np->add_arg(
		spec => 'subcommand|s=s',
		help => "-s, --subcommand=SUBCOMMAND\n"
		. '   Specify subcommand',
		required => 0,
	);

	$np->add_arg(
		spec => 'sessionfile|S=s',
		help => "-S, --sessionfile=SESSIONFILE\n"
		. '   Specify a filename to store sessions for faster authentication',
		required => 0,
	);

	$np->add_arg(
		spec => 'exclude|x=s',
		help => "-x, --exclude=<black_list>\n"
		. '   Specify black list',
		required => 0,
	);

	$np->add_arg(
		spec => 'options|o=s',
		help => "-o, --options=<additional_options> \n"
		. '   Specify additional command options (quickstats, ...)',
		required => 0,
	);

	$np->add_arg(
		spec => 'timestamp|T=i',
		help => "-T, --timestamp=<timeshift> \n"
		. '   Timeshift in seconds that could fix issues with "Unknown error". Use values like 5, 10, 20, etc',
		required => 0,
	);

	$np->add_arg(
		spec => 'interval|i=s',
		help => "-i, --interval=<sampling period> \n"
		. "   Sampling Period in seconds. Basic historic intervals: 300, 1800, 7200 or 86400. See config for any changes.\n"
		. "   Supports literval values to autonegotiate interval value: r - realtime interval, h<number> - historical interval specified by position.\n"
		. '   Default value is 20 (realtime). Since cluster does not have realtime stats interval other than 20(default realtime) is mandatory.',
		required => 0,
	);

	$np->add_arg(
		spec => 'maxsamples|M=s',
		help => "-M, --maxsamples=<max sample count> \n"
		. "   Maximum number of samples to retrieve. Max sample number is ignored for historic intervals.\n"
		. '   Default value is 1 (latest available sample). ',
		required => 0,
	);

	$np->add_arg(
		spec => 'trace=s',
		help => "--trace=<level> \n"
		. '   Set verbosity level of vSphere API request/respond trace',
		required => 0,
	);

	$np->add_arg(
		spec => 'generate_test=s',
		help => "--generate_test=<file> \n"
		. '   Generate a test case script from the executed command/subcommand and write it to <file>.'
		. '   If <file> is "stdout", the test case script is written to stdout instead.',
		default => 0,
		required => 0,
	);

	$np->getopts;

	my $host = $np->opts->host;
	my $cluster = $np->opts->cluster;
	my $datacenter = $np->opts->datacenter;
	my $vmname = $np->opts->name;
	my $username = $np->opts->username;
	my $password = $np->opts->password;
	my $authfile = $np->opts->authfile;
	my $warning = $np->opts->warning;
	my $critical = $np->opts->critical;
	my $command = $np->opts->command;
	my $subcommand = $np->opts->subcommand;
	my $sessionfile = $np->opts->sessionfile;
	my $blacklist = $np->opts->exclude;
	my $addopts = $np->opts->options;
	my $trace = $np->opts->trace;
	my $generate_test = $np->opts->generate_test;
	my $timeshift = $np->opts->timestamp;
	my $interval = $np->opts->interval;
	my $maxsamples = $np->opts->maxsamples;
	my $timeout = $np->opts->timeout;
	my $percw;
	my $percc;
	if ($generate_test) {
			if (uc($generate_test) ne "STDOUT") {
				-e $generate_test and die("cowardly refusing to write test case script to existing file ${generate_test}");
			}
			use LWP::UserAgent;
			my $cref = *LWP::UserAgent::request{CODE};
			{
				no warnings 'redefine';
				*LWP::UserAgent::request = sub {
					my $r = &{$cref}(@_); #$r is (hopefully) a SOAP response as returned by the VMware WS

					if (uc($generate_test) ne "STDOUT") {
						open TEST_SCRIPT, ">>", $generate_test;
						print TEST_SCRIPT $r->content . "\n!\n"; #print the response content to the target script. separate messages by '!' for easy parsing
					} else {
						print $r->content . "\n";
					}
					$r #pass it on
				};
			}
		}


	eval {
		require VMware::VIRuntime;
	} or Nagios::Plugin::Functions::nagios_exit(UNKNOWN, "Missing perl module VMware::VIRuntime. Download and install \'VMware vSphere SDK for Perl\', available at https://my.vmware.com/group/vmware/downloads\n $perl_module_instructions"); #This is, potentially, a lie. This might just as well fail if a dependency of VMware::VIRuntime is missing (i.e VIRuntime itself requires something which in turn fails).


	alarm($timeout) if $timeout;

	$output = "Unknown ERROR!";
	$result = CRITICAL;

	if (defined($subcommand))
	{
		$subcommand = undef if ($subcommand eq '');
	}

	if (defined($critical))
	{
		($percc, $critical) = check_percantage($critical);
		$critical = undef if ($critical eq '');
	}

	if (defined($warning))
	{
		($percw, $warning) = check_percantage($warning);
		$warning = undef if ($warning eq '');
	}

	$np->set_thresholds(critical => $critical, warning => $warning);

	$defperfargs = {};
	$defperfargs->{timeshift} = $timeshift if (defined($timeshift));
	$defperfargs->{interval} = $interval if (defined($interval));
	$defperfargs->{maxsamples} = $maxsamples if (defined($maxsamples));

	eval
	{
		die "Provide either Password/Username or Auth file or Session file\n" if ((!defined($password) || !defined($username) || defined($authfile)) && (defined($password) || defined($username) || !defined($authfile)) && (defined($password) || defined($username) || defined($authfile) || !defined($sessionfile)));
		die "Both threshold values must be the same units\n" if (($percw && !$percc && defined($critical)) || (!$percw && $percc && defined($warning)));
		if (defined($authfile))
		{
			open (AUTH_FILE, $authfile) || die "Unable to open auth file \"$authfile\"\n";
			while( <AUTH_FILE> ) {
				if(s/^[ \t]*username[ \t]*=//){
					s/^\s+//;s/\s+$//;
					$username = $_;
				}
				if(s/^[ \t]*password[ \t]*=//){
					s/^\s+//;s/\s+$//;
					$password = $_;
				}
			}
			die "Auth file must contain both username and password\n" if (!(defined($username) && defined($password)));
		}

		my $host_address;

		if (defined($datacenter))
		{
			$host_address = $datacenter;
		}
		elsif (defined($host))
		{
			$host_address = $host;
		}
		else
		{
			$np->nagios_exit(CRITICAL, "No Host or Datacenter specified");
		}

		$host_address .= ":443" if (index($host_address, ":") == -1);
		$host_address = "https://" . $host_address . "/sdk/webService";

		if (defined($sessionfile) and -e $sessionfile)
		{
			Opts::set_option("sessionfile", $sessionfile);
			eval {
				Util::connect($host_address, $username, $password);
				die "Connected host doesn't match reqested once\n" if (Opts::get_option("url") ne $host_address);
			};
			if ($@) {
				Opts::set_option("sessionfile", undef);
				Util::connect($host_address, $username, $password);
			}
		}
		else
		{
			Util::connect($host_address, $username, $password);
		}

		if (defined($sessionfile))
		{
			Vim::save_session(session_file => $sessionfile);
		}

		if (defined($trace))
		{
			$Util::tracelevel = $Util::tracelevel;
			$Util::tracelevel = $trace if (($trace =~ m/^\d$/) && ($trace >= 0) && ($trace <= 4));
		}

		$command = uc($command);
		if (defined($vmname))
		{
			if ($command eq "CPU")
			{
				($result, $output) = vm_cpu_info($vmname, $np, local_uc($subcommand));
			}
			elsif ($command eq "MEM")
			{
				($result, $output) = vm_mem_info($vmname, $np, local_uc($subcommand));
			}
			elsif ($command eq "NET")
			{
				($result, $output) = vm_net_info($vmname, $np, local_uc($subcommand));
			}
			elsif ($command eq "IO")
			{
				($result, $output) = vm_disk_io_info($vmname, $np, local_uc($subcommand));
			}
			elsif ($command eq "RUNTIME")
			{
				($result, $output) = vm_runtime_info($vmname, $np, local_uc($subcommand));
			}
			else
			{
				$output = "Unknown HOST-VM command\n" . $np->opts->_help;
				$result = CRITICAL;
			}
		}
		elsif (defined($host))
		{
			my $esx;
			$esx = {name => $host} if (defined($datacenter));
			if ($command eq "CPU")
			{
				($result, $output) = host_cpu_info($esx, $np, local_uc($subcommand), $addopts);
			}
			elsif ($command eq "MEM")
			{
				($result, $output) = host_mem_info($esx, $np, local_uc($subcommand), $addopts);
			}
			elsif ($command eq "NET")
			{
				($result, $output) = host_net_info($esx, $np, local_uc($subcommand));
			}
			elsif ($command eq "IO")
			{
				($result, $output) = host_disk_io_info($esx, $np, local_uc($subcommand));
			}
			elsif ($command eq "VMFS")
			{
				($result, $output) = host_list_vm_volumes_info($esx, $np, $subcommand, $blacklist, $percc || $percw, $addopts);
			}
			elsif ($command eq "RUNTIME")
			{
				($result, $output) = host_runtime_info($esx, $np, local_uc($subcommand), $blacklist, $addopts);
			}
			elsif ($command eq "SERVICE")
			{
				($result, $output) = host_service_info($esx, $np, $subcommand);
			}
			elsif ($command eq "STORAGE")
			{
				($result, $output) = host_storage_info($esx, $np, local_uc($subcommand), $blacklist);
			}
			elsif ($command eq "UPTIME")
			{
				($result, $output) = host_uptime_info($esx, $np, $addopts);
			}
			elsif ($command eq "DEVICE")
			{
				($result, $output) = host_device_info($esx, $np, $subcommand, $addopts);
			}
			else
			{
				$output = "Unknown HOST command\n" . $np->opts->_help;
				$result = CRITICAL;
			}
		}
		elsif (defined($cluster))
		{
			if ($command eq "CPU")
			{
				($result, $output) = cluster_cpu_info($cluster, $np, local_uc($subcommand));
			}
			elsif ($command eq "MEM")
			{
				($result, $output) = cluster_mem_info($cluster, $np, local_uc($subcommand), $addopts);
			}
			elsif ($command eq "CLUSTER")
			{
				($result, $output) = cluster_cluster_info($cluster, $np, local_uc($subcommand));
			}
			elsif ($command eq "VMFS")
			{
				($result, $output) = cluster_list_vm_volumes_info($cluster, $np, $subcommand, $blacklist, $percc || $percw, $addopts);
			}
			elsif ($command eq "RUNTIME")
			{
				($result, $output) = cluster_runtime_info($cluster, $np, local_uc($subcommand), $blacklist);
			}
			else
			{
				$output = "Unknown CLUSTER command\n" . $np->opts->_help;
				$result = CRITICAL;
			}
		}
		else
		{
			if ($command eq "RECOMMENDATIONS")
			{
				my $cluster_name;
				$cluster_name = {name => $subcommand} if (defined($subcommand));
				($result, $output) = return_cluster_DRS_recommendations($np, $cluster_name);
			}
			elsif ($command eq "CPU")
			{
				($result, $output) = dc_cpu_info($np, local_uc($subcommand), $addopts);
			}
			elsif ($command eq "MEM")
			{
				($result, $output) = dc_mem_info($np, local_uc($subcommand), $addopts);
			}
			elsif ($command eq "NET")
			{
				($result, $output) = dc_net_info($np, local_uc($subcommand));
			}
			elsif ($command eq "IO")
			{
				($result, $output) = dc_disk_io_info($np, local_uc($subcommand));
			}
			elsif ($command eq "VMFS")
			{
				($result, $output) = dc_list_vm_volumes_info($np, $subcommand, $blacklist, $percc || $percw, $addopts);
			}
			elsif ($command eq "RUNTIME")
			{
				($result, $output) = dc_runtime_info($np, local_uc($subcommand), $blacklist);
			}
			else
			{
				$output = "Unknown HOST command\n" . $np->opts->_help;
				$result = CRITICAL;
			}
		}
	};
	if ($@)
	{
		if (uc(ref($@)) eq "HASH")
		{
			$output = $@->{msg};
			$result = $@->{code};
		}
		else
		{
			$output = $@ . "";
			$result = CRITICAL;
		}
	}

	Util::disconnect();
	if ($generate_test && uc($generate_test) ne 'STDOUT') {
		open TEST_SCRIPT, ">>", $generate_test;
		print TEST_SCRIPT "#" . $output . "\n";
		print TEST_SCRIPT "-" . $result;
	}
	$np->nagios_exit($result, $output);
}
main unless defined caller;
#######################################################################################################################################################################

sub get_key_metrices {
	my ($perfmgr_view, $group, @names) = @_;

	my $perfCounterInfo = $perfmgr_view->perfCounter;
	my @counters;

	die "Insufficient rights to access perfcounters\n" if (!defined($perfCounterInfo));

	foreach (@$perfCounterInfo) {
		if ($_->groupInfo->key eq $group) {
			my $cur_name = $_->nameInfo->key . "." . $_->rollupType->val;
			foreach my $index (0..@names-1)
			{

				if ($names[$index] =~ /$cur_name/)
				{
					$names[$index] =~ /(\w+).(\w+):*(.*)/;
					$counters[$index] = PerfMetricId->new(counterId => $_->key, instance => $3);
				}
			}
		}
	}

	return \@counters;
}

sub generic_performance_values {
	my ($views, $perfargs, $group, @list) = @_;
	my $counter = 0;
	my @values = ();
	my $amount = @list;
	my $perfMgr = $perfargs->{perfCounter};
	if (!defined($perfMgr)) {
		$perfMgr = Vim::get_view(mo_ref => Vim::get_service_content()->perfManager, properties => [ 'perfCounter' ]);
		$perfargs->{perfCounter} = $perfMgr;
	}
	my $metrices = get_key_metrices($perfMgr, $group, @list);
	my $maxsamples = defined($perfargs->{maxsamples}) ? $perfargs->{maxsamples} : 1; #default 1 sample
	my $interval = defined($perfargs->{interval}) ? $perfargs->{interval} : 20; #retrive RefreshRate as default value
	my $timestamp = $perfargs->{timestamp};

	my @perf_query_spec = ();
	if (defined($timestamp)) {
		my $timeshift = $perfargs->{timeshift};
		my ($sec,$min,$hour,$mday,$mon,$year) = gmtime($timestamp - $timeshift);
		my $startTime = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

		($sec,$min,$hour,$mday,$mon,$year) = gmtime($timestamp);
		my $endTime = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

		if ($interval eq "r") {
			foreach (@$views) {
				my $summary = $perfMgr->QueryPerfProviderSummary(entity => $_);
				die "Realtime interval is not supported or not enabled\n" unless ($summary && $summary->currentSupported);
				$interval = $summary->refreshRate;
				push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples, startTime => $startTime, endTime => $endTime));
			}
		} elsif (substr($interval, 0, 1) eq "h") {
			my $index = substr($interval, 1, -1);
			foreach (@$views) {
				my $summary = $perfMgr->QueryPerfProviderSummary(entity => $_);
				die "Historical intervals are not supported\n" unless ($summary && $summary->summarySupported);
				my $historic_intervals = $perfMgr->historicalInterval;
				die "Historical interval [$index] is not present (max value " . @{$historic_intervals} . ")\n" unless (($index >= 0) && ($index < @{$historic_intervals}));
				my $perf_interval = $$historic_intervals[$index];
				die "Historical interval [$index] is disabled\n" unless ($perf_interval->enabled);
				$interval = $perf_interval->key;
				push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples, startTime => $startTime, endTime => $endTime));
			}
		} else {
			push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples, startTime => $startTime, endTime => $endTime)) foreach (@$views);
		}
	} else {
		if ($interval eq "r") {
			foreach (@$views) {
				my $summary = $perfMgr->QueryPerfProviderSummary(entity => $_);
				die "Realtime interval is not supported or not enabled\n" unless ($summary && $summary->currentSupported);
				$interval = $summary->refreshRate;
				push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples));
			}
		} elsif (substr($interval, 0, 1) eq "h") {
			my $index = substr($interval, 1, -1);
			foreach (@$views) {
				my $summary = $perfMgr->QueryPerfProviderSummary(entity => $_);
				die "Historical intervals are not supported\n" unless ($summary && $summary->summarySupported);
				my $historic_intervals = $perfMgr->historicalInterval;
				die "Historical interval [$index] is not present (max value " . @{$historic_intervals} . ")\n" unless (($index >= 0) && ($index < @{$historic_intervals}));
				my $perf_interval = $$historic_intervals[$index];
				die "Historical interval [$index] is disabled\n" unless ($perf_interval->enabled);
				$interval = $perf_interval->key;
				push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples));
			}
		} else {
			push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples)) foreach (@$views);
		}
	}
	my $perf_data = $perfMgr->QueryPerf(querySpec => \@perf_query_spec);
	$amount *= @$perf_data;

	while (@$perf_data)
	{
		my $unsorted = shift(@$perf_data)->value;
		my @host_values = ();

		foreach my $id (@$unsorted)
		{
			foreach my $index (0..@$metrices-1)
			{
				if ($id->id->counterId == $$metrices[$index]->counterId)
				{
					$counter++ if (!defined($host_values[$index]));
					$host_values[$index] = $id;
				}
			}
		}
		push(@values, \@host_values);
	}
	return undef if ($counter != $amount || $counter == 0);
	return \@values;
}

sub return_host_performance_values {
	my $values;
	my $host_name = shift(@_);
	my $perfargs = shift(@_);
	my $timeshift = $perfargs->{timeshift};
	my $host_view = Vim::find_entity_views(view_type => 'HostSystem', filter => $host_name, properties => (defined($timeshift) ? [ 'name', 'runtime.inMaintenanceMode', 'configManager.dateTimeSystem' ] : [ 'name', 'runtime.inMaintenanceMode']) ); # Added properties named argument.
	die "Runtime error\n" if (!defined($host_view));
	die "Host \"" . $$host_name{"name"} . "\" does not exist\n" if (!@$host_view);
	die {msg => ("NOTICE: \"" . $$host_view[0]->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($$host_view[0]->get_property('runtime.inMaintenanceMode')) eq "TRUE");

	# Timestamp is required for some Hosts in vCenter(Datacenter), this could fix 'Unknown error' type of issues
	$perfargs->{timestamp} = str2time(Vim::get_view(mo_ref => $$host_view[0]->get_property('configManager.dateTimeSystem'))->QueryDateTime()) if (defined($timeshift));
	$values = generic_performance_values($host_view, $perfargs, @_);

	return undef if ($@);
	return ($host_view, $values);
}

sub return_host_vmware_performance_values {
	my $values;
	my $vmname = shift(@_);
	my $vm_view = Vim::find_entity_views(view_type => 'VirtualMachine', filter => {name => "$vmname"}, properties => [ 'name', 'runtime.powerState' ]);
	die "Runtime error\n" if (!defined($vm_view));
	die "VMware machine \"" . $vmname . "\" does not exist\n" if (!@$vm_view);
	die "VMware machine \"" . $vmname . "\" is not running. Current state is \"" . $$vm_view[0]->get_property('runtime.powerState')->val . "\"\n" if ($$vm_view[0]->get_property('runtime.powerState')->val ne "poweredOn");

	my $perfargs = shift(@_);
	$perfargs->{timestamp} = time() if (exists($perfargs->{timeshift}));
	$values = generic_performance_values($vm_view, $perfargs, @_);

	return $@ if ($@);
	return ($vm_view, $values);
}

sub return_dc_performance_values {
	my $values;
	my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => [ 'name' ]);
	die "Runtime error\n" if (!defined($host_views));
	die "Datacenter does not contain any hosts\n" if (!@$host_views);

	my $perfargs = shift(@_);
	$perfargs->{timestamp} = time() if (exists($perfargs->{timeshift}));
	$values = generic_performance_values($host_views, $perfargs, @_);

	return undef if ($@);
	return ($host_views, $values);
}

sub return_cluster_performance_values {
	my $values;
	my $cluster_name = shift(@_);
	my $cluster_view = Vim::find_entity_views(view_type => 'ClusterComputeResource', filter => { name => "$cluster_name" }, properties => [ 'name' ]); # Added properties named argument.
	die "Runtime error\n" if (!defined($cluster_view));
	die "Cluster \"" . $cluster_name . "\" does not exist\n" if (!@$cluster_view);

	my $perfargs = shift(@_);
	die "Since cluster does not have realtime stats interval other than 20(default value) is mandatory\n" if (!exists($perfargs->{interval}));
	$perfargs->{timestamp} = time() if (exists($perfargs->{timeshift}));
	$values = generic_performance_values($cluster_view, $perfargs, @_);

	return undef if ($@);
	return $values;
}

# Temporary solution to overcome zeros in network output
sub return_host_temporary_vc_4_1_network_performance_values {
	my @values;
	my ($host_name, $perfargs, @list) = @_;

	my $host_view = Vim::find_entity_views(view_type => 'HostSystem', filter => $host_name, properties => [ 'name', 'runtime.inMaintenanceMode', 'summary.config.product.version', 'configManager.dateTimeSystem' ]); # Added properties named argument.
	die "Runtime error\n" if (!defined($host_view));
	die "Host \"" . $$host_name{"name"} . "\" does not exist\n" if (!@$host_view);
	die {msg => ("NOTICE: \"" . $$host_view[0]->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($$host_view[0]->get_property('runtime.inMaintenanceMode')) eq "TRUE");
	my $software_version = $$host_view[0]->get_property('summary.config.product.version');
	return undef if (substr($software_version, 0, 4) ne '4.1.');

	my $timeshift = $perfargs->{timeshift};
	my $interval = $perfargs->{interval};
	my $maxsamples = $perfargs->{maxsamples};
	my $timestamp = defined($timeshift) ? str2time(Vim::get_view(mo_ref => $$host_view[0]->get_property('configManager.dateTimeSystem'))->QueryDateTime()) : undef;

	my $perfMgr = Vim::get_view(mo_ref => Vim::get_service_content()->perfManager, properties => [ 'perfCounter' ]);
	my $metrices = get_key_metrices($perfMgr, 'net', @list);

	my $amount = @list;
	my @perf_query_spec = ();

	if (defined($timestamp)) {
		my ($sec,$min,$hour,$mday,$mon,$year) = gmtime($timestamp - $timeshift);
		my $endTime = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
		($sec,$min,$hour,$mday,$mon,$year) = gmtime($timestamp - $timeshift);
		my $startTime = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
		push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, startTime => $startTime, endtime => $endTime)) foreach (@$host_view);
	} else {
		push(@perf_query_spec, PerfQuerySpec->new(entity => $_, metricId => $metrices, format => 'csv', intervalId => $interval, maxSample => $maxsamples)) foreach (@$host_view);
	}
	my $perf_data = $perfMgr->QueryPerf(querySpec => \@perf_query_spec);
	$amount *= @$perf_data;

	my $counter = 0;
	while (@$perf_data)
	{
		my $unsorted = shift(@$perf_data)->value;
		my @host_values = ();

		foreach my $id (@$unsorted)
		{
			foreach my $index (0..@$metrices-1)
			{
				if ($id->id->counterId == $$metrices[$index]->counterId)
				{
					if (!defined($host_values[$index]))
					{
						$counter++;
						$host_values[$index] = bless({ 'value' => '0' }, "PerfMetricSeriesCSV");
					}
					$host_values[$index]{"value"} += convert_number($id->value) if ($id->id->instance ne '');
				}
			}
		}
		push(@values, \@host_values);
	}

	return undef if ($counter != $amount || $counter == 0 || $@);
	return ($host_view, \@values);
}
# Remove as soon as possible

sub local_uc
{
	my ($val) = shift(@_);
	return defined($val)?uc($val):undef;
}

sub simplify_number
{
	my ($number, $cnt) = @_;
	$cnt = 2 if (!defined($cnt));
	return sprintf("%.${cnt}f", "$number");
}

sub convert_number
{
	my @vals = split(/,/, shift(@_));
	my $res = 0;

	while (@vals) {
		my $value = pop(@vals);
		$value =~ s/^\s+//;
		$value =~ s/\s+$//;
		if (defined($value) && $value ne '') {
			return $value if ($value >= 0);
			$res = $value if ($res == 0);
		}
	}

	return $res;
}

sub check_percantage
{
	my ($number) = shift(@_);
	my $perc = $number =~ s/\%//;
	return ($perc, $number);
}

sub check_health_state
{
	my ($state) = shift(@_);
	my $res = UNKNOWN;

	if (uc($state) eq "GREEN") {
		$res = OK
	} elsif (uc($state) eq "YELLOW") {
		$res = WARNING;
	} elsif (uc($state) eq "RED") {
		$res = CRITICAL;
	}

	return $res;
}

sub format_issue {
	my ($issue) = shift(@_);

	my $output = '';

	if (defined($issue->datacenter))
	{
		$output .= 'Datacenter "' . $issue->datacenter->name . '", ';
	}
	if (defined($issue->host))
	{
		$output .= 'Host "' . $issue->host->name . '", ';
	}
	if (defined($issue->vm))
	{
		$output .= 'VM "' . $issue->vm->name . '", ';
	}
	if (defined($issue->computeResource))
	{
		$output .= 'Compute Resource "' . $issue->computeResource->name . '", ';
	}
	if (exists($issue->{dvs}) && defined($issue->dvs))
	{
		# Since vSphere API 4.0
		$output .= 'Virtual Switch "' . $issue->dvs->name . '", ';
	}
	if (exists($issue->{ds}) && defined($issue->ds))
	{
		# Since vSphere API 4.0
		$output .= 'Datastore "' . $issue->ds->name . '", ';
	}
	if (exists($issue->{net}) && defined($issue->net))
	{
		# Since vSphere API 4.0
		$output .= 'Network "' . $issue->net->name . '" ';
	}

	$output =~ s/, $/ /;
	$output .= ": " . $issue->fullFormattedMessage;
	$output .= "(caused by " . $issue->userName . ")" if ($issue->userName ne "");

	return $output;
}

sub datastore_volumes_info
{
	my ($datastore, $np, $subcommand, $blacklist, $perc, $addopts) = @_;

	my $res = OK;
	my $output = '';

	my $usedflag;
	my $briefflag;
	my $regexpflag;
	my $blackregexpflag;
	$usedflag = $addopts =~ m/(^|\s|\t|,)\Qused\E($|\s|\t|,)/ if (defined($addopts));
	$briefflag = $addopts =~ m/(^|\s|\t|,)\Qbrief\E($|\s|\t|,)/ if (defined($addopts));
	$regexpflag = $addopts =~ m/(^|\s|\t|,)\Qregexp\E($|\s|\t|,)/ if (defined($addopts));
	$blackregexpflag = $addopts =~ m/(^|\s|\t|,)\Qblacklistregexp\E($|\s|\t|,)/ if (defined($addopts));

	die "Blacklist is supported only in generic check or regexp subcheck\n" if (defined($subcommand) && defined($blacklist) && !defined($regexpflag));

	if (defined($regexpflag) && defined($subcommand))
	{
		eval
		{
			qr{$subcommand};
		};
		if ($@)
		{
			$@ =~ s/ at.*line.*\.//;
			die $@;
		}
	}

	my $state;
	foreach my $ref_store (@{$datastore})
	{
		my $store = Vim::get_view(mo_ref => $ref_store, properties => ['summary', 'info']);
		my $name = $store->summary->name;
		if (!defined($subcommand) || ($name eq $subcommand) || (defined($regexpflag) && $name =~ /$subcommand/))
		{
			if (defined($blacklist))
			{
				next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
			}

			if ($store->summary->accessible)
			{
				$store->RefreshDatastoreStorageInfo() if ($store->can("RefreshDatastoreStorageInfo") && exists($store->info->{timestamp}) && $defperfargs->{timeshift} && (time() - str2time($store->info->timestamp) > $defperfargs->{timeshift}));
				my $value1 = simplify_number(convert_number($store->summary->freeSpace) / 1024 / 1024);
				my $value2 = convert_number($store->summary->capacity);
				$value2 = simplify_number(convert_number($store->info->freeSpace) / $value2 * 100) if ($value2 > 0);

				if ($usedflag)
				{
					$value1 = simplify_number(convert_number($store->summary->capacity) / 1024 / 1024) - $value1;
					$value2 = 100 - $value2;
				}

				$state = $np->check_threshold(check => $perc?$value2:$value1);
				$res = Nagios::Plugin::Functions::max_state($res, $state);
				$np->add_perfdata(label => $name, value => $perc?$value2:$value1, uom => $perc?'%':'MB', threshold => $np->threshold);
				$output .= "'$name'" . ($usedflag ? "(used)" : "(free)") . "=". $value1 . " MB (" . $value2 . "%), " if (!$briefflag || $state != OK);
			}
			else
			{
				$res = CRITICAL;
				$output .= "'$name' is not accessible, ";
			}
			last if (!$regexpflag && defined($subcommand) && ($name eq $subcommand));
			$blacklist .= $blackregexpflag?"|^$name\$":",$name";
		}
	}

	if ($output)
	{
		chop($output);
		chop($output);
		$output = "Storages : " . $output;
	}
	else
	{
		if ($briefflag)
		{
			$output = "There are no alerts";
		}
		else
		{
			$res = WARNING;
			$output = defined($subcommand)?$regexpflag? "No matching volumes for regexp \"$subcommand\" found":"No volume named \"$subcommand\" found":"There are no volumes";
		}
	}

	return ($res, $output);
}

#=====================================================================| HOST |============================================================================#

sub host_cpu_info
{
	my ($host, $np, $subcommand, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'HOST CPU Unknown error';

	my $quickStats;
	$quickStats = $addopts =~ m/(^|\s|\t|,)\Qquickstats\E($|\s|\t|,)/ if (defined($addopts));

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime.inMaintenanceMode', 'summary.hardware', 'summary.quickStats']);
				die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
				die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
				$values = $host_view->get_property('summary.quickStats');
				my $hardinfo = $host_view->get_property('summary.hardware');
				$value = simplify_number($values->overallCpuUsage / ($hardinfo->numCpuCores * $hardinfo->cpuMhz) * 100) if exists($values->{overallCpuUsage}) && defined($hardinfo);
			}
			else
			{
				$values = return_host_performance_values($host, $defperfargs, 'cpu', ('usage.average'));
				$value = simplify_number(convert_number($$values[0][0]->value) * 0.01) if (defined($values));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "cpu_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "cpu usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMHZ")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime.inMaintenanceMode', 'summary.quickStats']);
				die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
				die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
				$values = $host_view->get_property('summary.quickStats');
				$value = simplify_number($values->overallCpuUsage) if exists($values->{overallCpuUsage});
			}
			else
			{
				$values = return_host_performance_values($host, $defperfargs, 'cpu', ('usagemhz.average'));
				$value = simplify_number(convert_number($$values[0][0]->value)) if (defined($values));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "cpu_usagemhz", value => $value, uom => 'MHz', threshold => $np->threshold);
				$output = "cpu usagemhz=" . $value . " MHz";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST CPU - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my $value1;
		my $value2;
		if (defined($quickStats))
		{
			my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime.inMaintenanceMode', 'summary.hardware', 'summary.quickStats']);
			die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
			die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
			$values = $host_view->get_property('summary.quickStats');
			my $hardinfo = $host_view->get_property('summary.hardware');
			if (exists($values->{overallCpuUsage}) && defined($hardinfo))
			{
				$value1 = simplify_number($values->overallCpuUsage);
				$value2 = simplify_number($values->overallCpuUsage / ($hardinfo->numCpuCores * $hardinfo->cpuMhz) * 100);
			}
		}
		else
		{
			$values = return_host_performance_values($host, $defperfargs, 'cpu', ('usagemhz.average', 'usage.average'));
			if ($values) {
				$value1 = simplify_number(convert_number($$values[0][0]->value));
				$value2 = simplify_number(convert_number($$values[0][1]->value) * 0.01);
			}
		}
		if (defined($value1) && defined($value2))
		{
			$np->add_perfdata(label => "cpu_usagemhz", value => $value1, uom => 'MHz', threshold => $np->threshold);
			$np->add_perfdata(label => "cpu_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$res = OK;
			$output = "cpu usage=" . $value1 . " MHz (" . $value2 . "%)";
		}
	}

	return ($res, $output);
}

sub host_mem_info
{
	my ($host, $np, $subcommand, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'HOST MEM Unknown error';

	my $quickStats;
	my $outputlist;
	$quickStats = $addopts =~ m/(^|\s|\t|,)\Qquickstats\E($|\s|\t|,)/ if (defined($addopts));
	$outputlist = $addopts =~ m/(^|\s|\t|,)\Qlistvm\E($|\s|\t|,)/ if (defined($addopts));

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime.inMaintenanceMode', 'summary.hardware', 'summary.quickStats']);
				die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
				die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
				$values = $host_view->get_property('summary.quickStats');
				my $hardinfo = $host_view->get_property('summary.hardware');
				$value = simplify_number($values->overallMemoryUsage / ($hardinfo->memorySize / 1024 / 1024) * 100) if exists($values->{overallMemoryUsage}) && defined($hardinfo);
			}
			else
			{
				$values = return_host_performance_values($host, $defperfargs, 'mem', ('usage.average'));
				$value = simplify_number(convert_number($$values[0][0]->value) * 0.01) if (defined($values));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "mem_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "mem usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMB")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime.inMaintenanceMode', 'summary.quickStats']);
				die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
				die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
				$values = $host_view->get_property('summary.quickStats');
				$value = simplify_number($values->overallMemoryUsage) if exists($values->{overallMemoryUsage});
			}
			else
			{
				$values = return_host_performance_values($host, $defperfargs, 'mem', ('consumed.average'));
				$value = simplify_number(convert_number($$values[0][0]->value) / 1024) if (defined($values));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "mem_usagemb", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "mem usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SWAP")
		{
			my $host_view;
			($host_view, $values) = return_host_performance_values($host, $defperfargs, 'mem', ('swapused.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_swap", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "swap usage=" . $value . " MB: ";
				$res = $np->check_threshold(check => $value);
				if ($res != OK && $outputlist)
				{
					my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $$host_view[0], properties => ['name', 'runtime.powerState']);
					die "Runtime error\n" if (!defined($vm_views));
					die "There are no VMs.\n" if (!@$vm_views);
					my @vms = ();
					foreach my $vm (@$vm_views)
					{
						push(@vms, $vm) if ($vm->get_property('runtime.powerState')->val eq "poweredOn");
					}
					$values = generic_performance_values(\@vms, $defperfargs, 'mem', ('swapped.average'));
					if (defined($values))
					{
						foreach my $index (0..@vms-1) {
							my $value = simplify_number(convert_number($$values[$index][0]->value) / 1024);
							$output .= $vms[$index]->name . " (" . $value . "MB), " if ($value > 0);
						}
					}
				}
				chop($output);
				chop($output);
			}
		}
		elsif ($subcommand eq "OVERHEAD")
		{
			$values = return_host_performance_values($host, $defperfargs, 'mem', ('overhead.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_overhead", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "overhead=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "OVERALL")
		{
			$values = return_host_performance_values($host, $defperfargs, 'mem', ('consumed.average', 'overhead.average'));
			if (defined($values))
			{
				my $value = simplify_number((convert_number($$values[0][0]->value) + convert_number($$values[0][1]->value)) / 1024);
				$np->add_perfdata(label => "mem_overhead", value =>  $value, uom => 'MB', threshold => $np->threshold);
				$output = "overall=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "MEMCTL")
		{
			my $host_view;
			($host_view, $values) = return_host_performance_values($host, $defperfargs, 'mem', ('vmmemctl.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_memctl", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "memctl=" . $value . " MB: ";
				$res = $np->check_threshold(check => $value);
				if ($res != OK && $outputlist)
				{
					my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $$host_view[0], properties => ['name', 'runtime.powerState']);
					die "Runtime error\n" if (!defined($vm_views));
					die "There are no VMs.\n" if (!@$vm_views);
					my @vms = ();
					foreach my $vm (@$vm_views)
					{
						push(@vms, $vm) if ($vm->get_property('runtime.powerState')->val eq "poweredOn");
					}
					$values = generic_performance_values(\@vms, $defperfargs, 'mem', ('vmmemctl.average'));
					if (defined($values))
					{
						foreach my $index (0..@vms-1) {
							my $value = simplify_number(convert_number($$values[$index][0]->value) / 1024);
							$output .= $vms[$index]->name . " (" . $value . "MB), " if ($value > 0);
						}
					}
				}
				chop($output);
				chop($output);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST MEM - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_host_performance_values($host, $defperfargs, 'mem', ('consumed.average', 'usage.average', 'overhead.average', 'swapused.average', 'vmmemctl.average'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value) / 1024);
			my $value2 = simplify_number(convert_number($$values[0][1]->value) * 0.01);
			my $value3 = simplify_number(convert_number($$values[0][2]->value) / 1024);
			my $value4 = simplify_number(convert_number($$values[0][3]->value) / 1024);
			my $value5 = simplify_number(convert_number($$values[0][4]->value) / 1024);
			$np->add_perfdata(label => "mem_usagemb", value => $value1, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_overhead", value => $value3, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_swap", value => $value4, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_memctl", value => $value5, uom => 'MB', threshold => $np->threshold);
			$res = OK;
			$output = "mem usage=" . $value1 . " MB (" . $value2 . "%), overhead=" . $value3 . " MB, swapped=" . $value4 . " MB, memctl=" . $value5 . " MB";
		}
	}

	return ($res, $output);
}

sub host_net_info
{
	my ($host, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST NET Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_host_temporary_vc_4_1_network_performance_values($host, $defperfargs, ('received.average:*', 'transmitted.average:*'));
			if ($values)
			{
				$$values[0][0]{"value"} += $$values[0][1]{"value"};
			}
			else
			{
				$values = return_host_performance_values($host, $defperfargs, 'net', ('usage.average'));
			}
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "net_usage", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "net usage=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "RECEIVE")
		{
			$values = return_host_temporary_vc_4_1_network_performance_values($host, $defperfargs, ('received.average:*'));
			$values = return_host_performance_values($host, $defperfargs, 'net', ('received.average')) if (!$values);
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "net_receive", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "net receive=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SEND")
		{
			$values = return_host_temporary_vc_4_1_network_performance_values($host, $defperfargs, ('transmitted.average:*'));
			$values = return_host_performance_values($host, $defperfargs, 'net', ('transmitted.average')) if (!$values);
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "net_send", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "net send=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "NIC")
		{
			my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'configManager.networkSystem', 'runtime.inMaintenanceMode']);
			die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
			die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
			my $network_system = Vim::get_view(mo_ref => $host_view->get_property('configManager.networkSystem') , properties => ['networkInfo']);
			$network_system->update_view_data(['networkInfo']);
			my $network_config = $network_system->networkInfo;
			die "Host \"" . $$host{"name"} . "\" has no network info in the API.\n" if (!defined($network_config));

			$output = "";
			$res = OK;
			my $OKCount = 0;
			my $BadCount = 0;
			my @switches = ();

			# create a hash of NIC info to facilitate easy lookups
			my %NIC = ();
			foreach (@{$network_config->pnic})
			{
				$NIC{$_->key} = $_;
			}

			push(@switches, $network_config->vswitch) if (exists($network_config->{vswitch}));
			push(@switches, $network_config->proxySwitch) if (exists($network_config->{proxySwitch}));

			# see which NICs are actively part of a switch
			foreach my $switch (@switches)
			{
				foreach (@{$switch})
				{
					# get list of physical nics
					if (defined($_->pnic)){
						foreach my $nic_key (@{$_->pnic})
						{
							if (!defined($NIC{$nic_key}->linkSpeed))
							{
								$output .= ", " if ($output);
								$output .= $NIC{$nic_key}->device . " is unplugged";
								$res = CRITICAL;
								$BadCount++;
							}
							else
							{
								$OKCount++;
							}
						}
					}
				}
			}

			if (!$BadCount)
			{
				$output = "All $OKCount NICs are connected";
			}
			else
			{
				$output = $BadCount ."/" . ($BadCount + $OKCount) . " NICs are disconnected: " . $output;
			}
			$np->add_perfdata(label => "OK_NICs", value => $OKCount);
			$np->add_perfdata(label => "Bad_NICs", value => $BadCount);
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST NET - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my $host_view;
		($host_view, $values) = return_host_performance_values($host, $defperfargs, 'net', ('received.average', 'transmitted.average'));
		$output = '';
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value));
			my $value2 = simplify_number(convert_number($$values[0][1]->value));

			$host_view = $$host_view[0];
			$host_view->update_view_data(['configManager.networkSystem']);
			my $network_system = Vim::get_view(mo_ref => $host_view->get_property('configManager.networkSystem') , properties => ['networkInfo']);
			$network_system->update_view_data(['networkInfo']);
			my $network_config = $network_system->networkInfo;
			if (defined($network_config))
			{
				my $OKCount = 0;
				my $BadCount = 0;

				# create a hash of NIC info to facilitate easy lookups
				my %NIC = ();
				foreach (@{$network_config->pnic})
				{
					$NIC{$_->key} = $_;
				}

				my $nic_output = '';
				my @switches = ();

				push(@switches, $network_config->vswitch) if (exists($network_config->{vswitch}));
				push(@switches, $network_config->proxySwitch) if (exists($network_config->{proxySwitch}));

				# see which NICs are actively part of a switch
				foreach my $switch (@switches)
				{
					foreach (@{$switch})
					{
						# get list of physical nics
						if (defined($_->pnic)){
							foreach my $nic_key (@{$_->pnic})
							{
								if (!defined($NIC{$nic_key}->linkSpeed))
								{
									$nic_output .= ", " if ($output);
									$nic_output .= $NIC{$nic_key}->device . " is unplugged";
									$res = CRITICAL;
									$BadCount++;
								}
								else
								{
									$OKCount++;
								}
							}
						}
					}
				}


				$res = OK;
				$output = "net receive=" . $value1 . " KBps, send=" . $value2 . " KBps, ";
				$np->add_perfdata(label => "net_receive", value => $value1, uom => 'KBps', threshold => $np->threshold);
				$np->add_perfdata(label => "net_send", value => $value2, uom => 'KBps', threshold => $np->threshold);

				if (!$BadCount)
				{
					$output .= "all $OKCount NICs are connected";
				}
				else
				{
					$output .= $BadCount ."/" . ($BadCount + $OKCount) . " NICs are disconnected: " . $nic_output;
				}
				$np->add_perfdata(label => "OK_NICs", value => $OKCount);
				$np->add_perfdata(label => "Bad_NICs", value => $BadCount);
			}
			else
			{
				$output = "NIC data is not available";
			}
		}
	}

	return ($res, $output);
}

sub host_disk_io_info
{
	my ($host, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST IO Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "ABORTED")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('commandsAborted.summation:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_aborted", value => $value, threshold => $np->threshold);
				$output = "io commands aborted=" . $value;
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "RESETS")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('busResets.summation:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_busresets", value => $value, threshold => $np->threshold);
				$output = "io bus resets=" . $value;
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "READ")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('totalReadLatency.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_read", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io read latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "WRITE")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('totalWriteLatency.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_write", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io write latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "KERNEL")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('kernelLatency.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_kernel", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io kernel latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "DEVICE")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('deviceLatency.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_device", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io device latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "QUEUE")
		{
			$values = return_host_performance_values($host, $defperfargs, 'disk', ('queueLatency.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value), 0);
				$np->add_perfdata(label => "io_queue", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io queue latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST IO - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_host_performance_values($host, $defperfargs, 'disk', ('commandsAborted.summation:*', 'busResets.summation:*', 'totalReadLatency.average:*', 'totalWriteLatency.average:*', 'kernelLatency.average:*', 'deviceLatency.average:*', 'queueLatency.average:*'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value), 0);
			my $value2 = simplify_number(convert_number($$values[0][1]->value), 0);
			my $value3 = simplify_number(convert_number($$values[0][2]->value), 0);
			my $value4 = simplify_number(convert_number($$values[0][3]->value), 0);
			my $value5 = simplify_number(convert_number($$values[0][4]->value), 0);
			my $value6 = simplify_number(convert_number($$values[0][5]->value), 0);
			my $value7 = simplify_number(convert_number($$values[0][6]->value), 0);
			$np->add_perfdata(label => "io_aborted", value => $value1, threshold => $np->threshold);
			$np->add_perfdata(label => "io_busresets", value => $value2, threshold => $np->threshold);
			$np->add_perfdata(label => "io_read", value => $value3, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_write", value => $value4, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_kernel", value => $value5, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_device", value => $value6, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_queue", value => $value7, uom => 'ms', threshold => $np->threshold);
			$res = OK;
			$output = "io commands aborted=" . $value1 . ", io bus resets=" . $value2 . ", io read latency=" . $value3 . " ms, write latency=" . $value4 . " ms, kernel latency=" . $value5 . " ms, device latency=" . $value6 . " ms, queue latency=" . $value7 ." ms";
		}
	}

	return ($res, $output);
}

sub host_list_vm_volumes_info
{
	my ($host, $np, $subcommand, $blacklist, $perc, $addopts) = @_;

	my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'datastore', 'runtime.inMaintenanceMode']);
	die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
	die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
	die "Insufficient rights to access Datastores on the Host\n" if (!defined($host_view->datastore));

	return datastore_volumes_info($host_view->datastore, $np, $subcommand, $blacklist, $perc, $addopts);
}

sub host_runtime_info
{
	my ($host, $np, $subcommand, $blacklist, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'HOST RUNTIME Unknown error';
	my $runtime;
	my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime', 'overallStatus', 'configIssue']);
	die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
	$host_view->update_view_data(['name', 'runtime', 'overallStatus', 'configIssue']);
	$runtime = $host_view->runtime;
	die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if ($runtime->inMaintenanceMode);

	my %base_units = (
		'Degrees C' => 'C',
		'Degrees F' => 'F',
		'Degrees K' => 'K',
		'Volts' => 'V',
		'Amps' => 'A',
		'Watts' => 'W',
		'Percentage' => 'Pct'
	);
	my $blackregexpflag;
	my $listitems;
	$blackregexpflag = $addopts =~ m/(^|\s|\t|,)\Qblacklistregexp\E($|\s|\t|,)/ if (defined($addopts));
	$listitems = $addopts =~ m/(^|\s|\t|,)\Qlistitems\E($|\s|\t|,)/ if (defined($addopts));

	if (defined($subcommand))
	{
		if ($subcommand eq "CON")
		{
			$output = "connection state=" . $runtime->connectionState->val;
			$res = OK if (uc($runtime->connectionState->val) eq "CONNECTED");
		}
		elsif ($subcommand eq "HEALTH")
		{
			my $OKCount = 0;
			my $AlertCount = 0;
			my ($cpuStatusInfo, $storageStatusInfo, $memoryStatusInfo, $numericSensorInfo);
			my $components = {};

			$res = UNKNOWN;

			if(defined($runtime->healthSystemRuntime))
			{
				$cpuStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->cpuStatusInfo;
				$storageStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->storageStatusInfo;
				$memoryStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->memoryStatusInfo;
				$numericSensorInfo = $runtime->healthSystemRuntime->systemHealthInfo->numericSensorInfo;

				if (defined($cpuStatusInfo) || defined($storageStatusInfo) || defined($memoryStatusInfo) || defined($numericSensorInfo)) {
					$res = OK;
				}
				$output = '';

				if (defined($cpuStatusInfo))
				{
					foreach (@$cpuStatusInfo)
					{
						# print "CPU Name = ". $_->name .", Label = ". $_->status->label . ", Summary = ". $_->status->summary . ", Key = ". $_->status->key . "\n";
						if (defined($blacklist))
						{
							my $name = $_->name;
							next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
						}
						my $state = check_health_state($_->status->key);
						my $itemref = {
							name => $_->name,
							summary => $_->status->summary
						};
						push(@{$components->{$state}{CPU}}, $itemref);
						$res = Nagios::Plugin::Functions::max_state_alt($res, $state);
						if ($state != OK) {
							$AlertCount++;
						} else {
							$OKCount++;
						}
					}
				}

				if (defined($storageStatusInfo))
				{
					foreach (@$storageStatusInfo)
					{
						# print "Storage Name = ". $_->name .", Label = ". $_->status->label . ", Summary = ". $_->status->summary . ", Key = ". $_->status->key . "\n";
						if (defined($blacklist))
						{
							my $name = $_->name;
							next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
						}
						my $state = check_health_state($_->status->key);
						my $itemref = {
							name => $_->name,
							summary => $_->status->summary
						};
						push(@{$components->{$state}{Storage}}, $itemref);
						$res = Nagios::Plugin::Functions::max_state_alt($res, $state);
						if ($state != OK) {
							$AlertCount++;
						} else {
							$OKCount++;
						}
					}
				}

				if (defined($memoryStatusInfo))
				{
					foreach (@$memoryStatusInfo)
					{
						# print "Memory Name = ". $_->name .", Label = ". $_->status->label . ", Summary = ". $_->status->summary . ", Key = ". $_->status->key . "\n";
						if (defined($blacklist))
						{
							my $name = $_->name;
							next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
						}
						my $state = check_health_state($_->status->key);
						my $itemref = {
							name => $_->name,
							summary => $_->status->summary
						};
						push(@{$components->{$state}{Memory}}, $itemref);
						$res = Nagios::Plugin::Functions::max_state_alt($res, $state);
						if ($state != OK) {
							$AlertCount++;
						} else {
							$OKCount++;
						}
					}
				}

				if (defined($numericSensorInfo))
				{
					foreach (@$numericSensorInfo)
					{
						# print "Sensor Name = ". $_->name .", Type = ". $_->sensorType . ", Label = ". $_->healthState->label . ", Summary = ". $_->healthState->summary . ", Key = " . $_->healthState->key . "\n";
						if (defined($blacklist))
						{
							my $name = $_->name;
							next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
						}
						my $state = check_health_state($_->healthState->key);
						my $itemref = {
							name => $_->name,
							summary => $_->healthState->summary
						};
						push(@{$components->{$state}{$_->sensorType}}, $itemref);
						$res = Nagios::Plugin::Functions::max_state_alt($res, $state);
						if ($state != OK) {
							$AlertCount++;
						} else {
							$OKCount++;
						}
					}
				}

				if ($listitems) {
					foreach my $fstate (reverse(sort(keys(%$components)))) {
						foreach my $state_ref ($components->{$fstate}) {
							foreach my $type (keys(%$state_ref)) {
								foreach my $item_ref (@{$state_ref->{$type}}) {
									$output .=  "($STATUS_TEXT{$fstate})  \[$type\]  |  $item_ref->{name}  |  $item_ref->{summary}\n";
								}
							}
						}
					}
				} else {
					if ($AlertCount > 0) {
						$output = "$AlertCount health issue(s) found in " . ($AlertCount + $OKCount) . " checks:\n";
						my $AlertIndex = 0;
						foreach my $fstate (reverse(sort(keys(%$components)))) {
							next if ($fstate == 0);
							foreach my $state_ref ( $components->{$fstate}) {
								foreach my $type ( keys(%$state_ref)) {
									foreach my $item_ref (@{$state_ref->{$type}}) {
										$output .=  ++$AlertIndex . ") $STATUS_TEXT{$fstate}\[$type\] Status of $item_ref->{name}: $item_ref->{summary}\n";
									}
								}
							}
						}
					} else {
						$output = "All $OKCount health checks are GREEN:";
						foreach my $type (keys(%{$components->{0}})) {
							$output .= " " . $type . " (" . (scalar(@{$components->{0}{$type}})) . "x);";
						}
					}
				}
			}
			else
			{
				$output = "System health status unavailable";
			}

			$np->add_perfdata(label => "Alerts", value => $AlertCount);
		}
		elsif ($subcommand eq "STORAGEHEALTH")
		{
			my $OKCount = 0;
			my $AlertCount = 0;
			my $storageStatusInfo;
			my $components = {};
			$res = UNKNOWN;

			if(defined($runtime->healthSystemRuntime) && defined($runtime->healthSystemRuntime->hardwareStatusInfo->storageStatusInfo))
			{
				$storageStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->storageStatusInfo;
				$output = '';
				foreach (@$storageStatusInfo)
				{
					if (defined($blacklist))
					{
						my $name = $_->name;
						next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
					}
					my $state = check_health_state($_->status->key);
					$components->{$state}{"Storage"}{$_->name} = $_->status->summary;
					if ($state != OK)
					{
						$res = Nagios::Plugin::Functions::max_state($res, $state);
						$AlertCount++;
					} else {
						$OKCount++;
					}
				}

				foreach my $fstate (reverse(sort(keys(%$components)))) {
					foreach my $state_ref ($components->{$fstate}) {
						foreach my $type (keys(%$state_ref)) {
							foreach my $name (keys(%{$state_ref->{$type}})) {
								$output .=  "$STATUS_TEXT{$fstate}: Status of $name: $state_ref->{$type}{$name}\n";
							}
						}
					}
				}

				if ($AlertCount > 0) {
					$output = "$AlertCount health issue(s) found: \n" . $output;
				} else {
					$output = "All $OKCount Storage health checks are GREEN: \n" . $output;
					$res = OK;
				}
			}
			else
			{
				$res = UNKNOWN;
				$output = "Storage health status unavailable";
			}
			$np->add_perfdata(label => "Alerts", value => $AlertCount);
		}
		elsif ($subcommand eq "TEMPERATURE")
		{
			my $OKCount = 0;
			my $AlertCount = 0;
			my $numericSensorInfo;
			my $components = {};
			$res = UNKNOWN;

			if(defined($runtime->healthSystemRuntime))
			{
				$numericSensorInfo = $runtime->healthSystemRuntime->systemHealthInfo->numericSensorInfo;
				$output = '';

				if (defined($numericSensorInfo))
				{
					foreach (@$numericSensorInfo)
					{
						# print "Sensor Name = ". $_->name .", Type = ". $_->sensorType . ", Label = ". $_->healthState->label . ", Summary = ". $_->healthState->summary . ", Key = " . $_->healthState->key . "\n";
						next if (uc($_->sensorType) ne 'TEMPERATURE');
						if (defined($blacklist))
						{
							my $name = $_->name;
							next if ($blackregexpflag?$name =~ /$blacklist/:$blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
						}

						my $state = check_health_state($_->healthState->key);
						$_->name =~ m/(.*?)\sTemp\s.+/;
						my $itemref = {
							name => $1,
							power10 => $_->unitModifier,
							state => $_->healthState->key,
							value => $_->currentReading,
							unit => $_->baseUnits,
						};
						push(@{$components->{$state}}, $itemref);
						if ($state != OK)
						{
							$res = Nagios::Plugin::Functions::max_state($res, $state);
							$AlertCount++;
						}
						else
						{
							$OKCount++;
						}
						if (exists($base_units{$itemref->{unit}}))
						{
							$np->add_perfdata(label => $itemref->{name}, value => ($itemref->{value} * 10 ** $itemref->{power10}), uom => $base_units{$itemref->{unit}});
						}
						else
						{
							$np->add_perfdata(label => $itemref->{name}, value => ($itemref->{value} * 10 ** $itemref->{power10}));
						}
					}
				}

				foreach my $curstate (reverse(sort(keys(%$components))))
				{
					foreach my $itemref (@{$components->{$curstate}})
					{
						my $value = $itemref->{value} * 10 ** $itemref->{power10};
						my $unit = exists($base_units{$itemref->{unit}}) ? $base_units{$itemref->{unit}} : '';
						my $name = $itemref->{name};
						$output .= ", " if ($output);
						$output .=  "$STATUS_TEXT{$curstate} : $name = $value $unit";
					}
				}

				if ($AlertCount > 0)
				{
					$output = "$AlertCount temperature issue(s) found:" . $output;
				}
				else
				{
					$output = "All $OKCount temperature checks are GREEN: " . $output;
					$res = OK;
				}
			}
			else
			{
				$output = "Temperature status unavailable";
			}
		}
		elsif ($subcommand eq "SENSOR")
		{
			die "Provide sensor name as -o argument\n" if (!$addopts);
			$output = '';
			if(defined($runtime->healthSystemRuntime))
			{
				my $numericSensorInfo = $runtime->healthSystemRuntime->systemHealthInfo->numericSensorInfo;

				if (defined($numericSensorInfo))
				{
					if ($addopts eq "listall")
					{
						foreach (@$numericSensorInfo)
						{
							$output .= "'" . $_->name . "', ";
						}
						if ($output)
						{
							chop($output);
							chop($output);
							$output = "numeric sensor list :" . $output;
						}
						else
						{
							$output = "numeric sensors unavailable";
						}
					}
					else
					{
						foreach (@$numericSensorInfo)
						{
							if ($_->name =~ $addopts)
							{
								my $value = $_->currentReading * 10 ** $_->unitModifier;
								$output = "sensor '" . $_->name . "' = " . $value . (defined($_->baseUnits) ? " " . $_->baseUnits : "");
								$res = $np->check_threshold(check => $value);
								$np->add_perfdata(label => $_->name, value => $value, threshold => $np->threshold);
								last;
							}
						}
						$output = "Can not find sensor by name '" . $addopts . "'" if (!$output);
					}
				}
				else
				{
					$res = UNKNOWN;
					$output = "System numeric sensors status unavailable";
				}
			}
			else
			{
				$res = UNKNOWN;
				$output = "System health status unavailable";
			}
		}
		elsif ($subcommand eq "MAINTENANCE")
		{
			my %host_maintenance_state = (0 => "no", 1 => "yes");
			$output = "maintenance=" . $host_maintenance_state{$runtime->inMaintenanceMode};
			$res = OK;
		}
		elsif (($subcommand eq "LIST") || ($subcommand eq "LISTVM"))
		{
			my %vm_state_strings = ("poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED");
			my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $host_view, properties => ['name', 'runtime']);
			die "Runtime error\n" if (!defined($vm_views));
			die "There are no VMs.\n" if (!@$vm_views);
			my $up = 0;
			$output = '';

			foreach my $vm (@$vm_views)
			{
				my $vm_state = $vm_state_strings{$vm->runtime->powerState->val};
				if ($vm_state eq "UP")
				{
					$up++;
					$output .= $vm->name . "(OK), ";
				}
				else
				{
					$output = $vm->name . "(" . $vm_state . "), " . $output;
				}
			}

			chop($output);
			chop($output);
			$res = OK;
			$output = $up . "/" . @$vm_views . " VMs up: " . $output;
			$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);
			$res = $np->check_threshold(check => $up) if (defined($np->threshold));
		}
		elsif ($subcommand eq "STATUS")
		{
			my $status = $host_view->overallStatus->val;
			$output = "overall status=" . $status;
			$res = check_health_state($status);
		}
		elsif ($subcommand eq "ISSUES")
		{
			my $issues = $host_view->configIssue;

			$output = '';
			if (defined($issues))
			{
				foreach (@$issues)
				{
					if (defined($blacklist))
					{
						my $name = ref($_);
						next if ($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
					}
					$output .= format_issue($_) . "; ";
				}
			}

			if ($output eq '')
			{
				$res = OK;
				$output = 'No config issues';
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST RUNTIME - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my %host_maintenance_state = (0 => "no", 1 => "yes");
		my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $host_view, properties => ['name', 'runtime']);
		my $up = 0;

		die "Runtime error\n" if (!defined($vm_views));
		if (@$vm_views)
		{
			foreach my $vm (@$vm_views)
			{
				$up += $vm->runtime->powerState->val eq "poweredOn";
			}
			$output = $up . "/" . @$vm_views . " VMs up";
		}
		else
		{
			$output = "No VMs installed";
		}
		$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);

		my $AlertCount = 0;
		my $SensorCount = 0;
		my ($cpuStatusInfo, $storageStatusInfo, $memoryStatusInfo, $numericSensorInfo);
		if(defined($runtime->healthSystemRuntime))
		{
			$cpuStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->cpuStatusInfo;
			$storageStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->storageStatusInfo;
			$memoryStatusInfo = $runtime->healthSystemRuntime->hardwareStatusInfo->memoryStatusInfo;
			$numericSensorInfo = $runtime->healthSystemRuntime->systemHealthInfo->numericSensorInfo;
		}

		if (defined($cpuStatusInfo))
		{
			foreach (@$cpuStatusInfo)
			{
				$SensorCount++;
				$AlertCount++ if (check_health_state($_->status->key) != OK);
			}
		}

		if (defined($storageStatusInfo))
		{
			foreach (@$storageStatusInfo)
			{
				$SensorCount++;
				$AlertCount++ if (check_health_state($_->status->key) != OK);
			}
		}

		if (defined($memoryStatusInfo))
		{
			foreach (@$memoryStatusInfo)
			{
				$SensorCount++;
				$AlertCount++ if (check_health_state($_->status->key) != OK);
			}
		}

		if (defined($numericSensorInfo))
		{
			foreach (@$numericSensorInfo)
			{
				$SensorCount++;
				$AlertCount++ if (check_health_state($_->healthState->key) != OK);
			}
		}

		$res = OK;
		$output .= ", overall status=" . $host_view->overallStatus->val . ", connection state=" . $runtime->connectionState->val . ", maintenance=" . $host_maintenance_state{$runtime->inMaintenanceMode} . ", ";

		if ($AlertCount)
		{
			$output .= "$AlertCount health issue(s), ";
		}
		else
		{
			$output .= "All $SensorCount health checks are Green, ";
		}
		$np->add_perfdata(label => "health_issues", value => $AlertCount);

		my $issues = $host_view->configIssue;
		if (defined($issues))
		{
			$output .= @$issues . " config issue(s)";
			$np->add_perfdata(label => "config_issues", value => "" . @$issues);
		}
		else
		{
			$output .= "no config issues";
			$np->add_perfdata(label => "config_issues", value => 0);
		}
	}

	return ($res, $output);
}

sub host_service_info
{
	my ($host, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST RUNTIME Unknown error';
	my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'configManager', 'runtime.inMaintenanceMode']);
	die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
	die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");

	my $services = Vim::get_view(mo_ref => $host_view->configManager->serviceSystem, properties => ['serviceInfo'])->serviceInfo->service;

	if (defined($subcommand))
	{
		$subcommand = ',' . $subcommand . ',';
		$output = '';
		foreach (@$services)
		{
			my $srvname = $_->key;
			if ($subcommand =~ s/,$srvname,/,/g)
			{
				while ($subcommand =~ s/,$srvname,/,/g){};
				$output .= $srvname . ", " if (!$_->running);
			}
		}
		$subcommand =~ s/^,//;
		chop($subcommand);

		if ($subcommand ne '')
		{
			$res = UNKNOWN;
			$output = "unknown services : $subcommand";
		}
		elsif ($output eq '')
		{
			$res = OK;
			$output = "All services are in their apropriate state.";
		}
		else
		{
			chop($output);
			chop($output);
			$output .= " are down";
		}
	}
	else
	{
		my %service_state = (0 => "down", 1 => "up");
		$res = OK;
		$output = "services : ";
		$output .= $_->key . " (" . $service_state{$_->running} . "), " foreach (@$services);
		chop($output);
		chop($output);
	}

	return ($res, $output);
}

sub host_storage_info
{
	my ($host, $np, $subcommand, $blacklist) = @_;

	my $count = 0;
	my $res = CRITICAL;
	my $output = 'HOST RUNTIME Unknown error';
	my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'configManager', 'runtime.inMaintenanceMode']);
	die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
	die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");

	my $storage = Vim::get_view(mo_ref => $host_view->configManager->storageSystem, properties => ['storageDeviceInfo']);

	if (defined($subcommand))
	{
		if ($subcommand eq "ADAPTER")
		{
			$output = "";
			$res = OK;
			foreach my $dev (@{$storage->storageDeviceInfo->hostBusAdapter})
			{
				my $name = $dev->device;
				my $status = $dev->status;
				if (defined($blacklist))
				{
					my $key = $dev->key;
					if (($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/) || ($blacklist =~ m/(^|\s|\t|,)\Q$key\E($|\s|\t|,)/))
					{
						$count++;
						$status = "ignored";
					}
				}
				$count ++ if (uc($status) eq "ONLINE");
				$res = UNKNOWN if (uc($status) eq "UNKNOWN");
				$output .= $name . " (" . $status . "); ";
			}
			my $state = $np->check_threshold(check => $count);
			$res = $state if ($state != OK);
			$np->add_perfdata(label => "adapters", value => $count, uom => 'units', threshold => $np->threshold);
		}
		elsif ($subcommand eq "LUN")
		{
			$output = "";
			$res = OK;
			my $state = OK; # For unkonwn or other statuses
			foreach my $scsi (@{$storage->storageDeviceInfo->scsiLun})
			{
				my $name = "";
				if (exists($scsi->{displayName}))
				{
					$name = $scsi->displayName;
				}
				elsif (exists($scsi->{canonicalName}))
				{
					$name = $scsi->canonicalName;
				}
				else
				{
					$name = $scsi->deviceName;
				}
				$state = OK;

				my $operationState;
				if (defined($blacklist) && ($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/))
				{
					$operationState = "ignored";
				}
				else
				{
					$operationState = join("-", @{$scsi->operationalState});
					foreach (@{$scsi->operationalState})
					{
						if (uc($_) eq "OK")
						{
							# $state = OK;
						}
						elsif (uc($_) eq "UNKNOWN")
						{
							$res = UNKNOWN;
						}
						elsif (uc($_) eq "UNKNOWNSTATE")
						{
							$res = UNKNOWN;
						}
						else
						{
							$state = CRITICAL;
						}
					}
				}

				$count++ if ($state == OK);
				$output .= $name . " <" . $operationState . ">; ";
			}
			$np->add_perfdata(label => "LUNs", value => $count, uom => 'units', threshold => $np->threshold);
			$state = $np->check_threshold(check => $count);
			$res = $state if ($state != OK);
		}
		elsif ($subcommand eq "PATH")
		{
			if (exists($storage->storageDeviceInfo->{multipathInfo}))
			{
				$output = "";
				$res = OK;
				foreach my $lun (@{$storage->storageDeviceInfo->multipathInfo->lun})
				{
					foreach my $path (@{$lun->path})
					{
						my $status = UNKNOWN; # For unknown or other statuses
						my $pathState = "unknown";
						my $name = $path->name;

						if (exists($path->{state}))
						{
							$pathState = $path->state;
						}
						else
						{
							$pathState = $path->pathState;
						}

						if (defined($blacklist) && ($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/))
						{
							$pathState = "ignored";
							$count++;
						}

						my $normalizedPathState = uc($pathState);
						$count++ if ($normalizedPathState eq "ACTIVE");
						$res = UNKNOWN if (($res == OK) && ($normalizedPathState eq "UNKNOWN"));
						$res = CRITICAL if ($normalizedPathState eq "DEAD");
						$output .= $name . " <" . $pathState . ">; ";
					}
				}
				$np->add_perfdata(label => "paths", value => $count, uom => 'units', threshold => $np->threshold);
				my $state = $np->check_threshold(check => $count);
				$res = $state if ($state != OK);
			}
			else
			{
				$output = "path info is unavailable on this host";
				$res = UNKNOWN;
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST STORAGE - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my $status = UNKNOWN;
		my $state = OK;
		$output = "";
		$res = OK;
		foreach my $dev (@{$storage->storageDeviceInfo->hostBusAdapter})
		{
			$status = UNKNOWN;
			if (uc($dev->status) eq "ONLINE")
			{
				$status = OK;
				$count++;
			}
			elsif (uc($dev->status) eq "OFFLINE")
			{
				$status = CRITICAL;
			}
			elsif (uc($dev->status) eq "FAULT")
			{
				$status = CRITICAL;
			}
			else
			{
				$res = UNKNOWN;
			}
			$state = Nagios::Plugin::Functions::max_state($state, $status);
		}
		$np->add_perfdata(label => "adapters", value => $count, uom => 'units', threshold => $np->threshold);
		$output .= $count . "/" . @{$storage->storageDeviceInfo->hostBusAdapter} . " adapters online, ";

		$count = 0;
		foreach my $scsi (@{$storage->storageDeviceInfo->scsiLun})
		{
			$status = UNKNOWN;
			foreach (@{$scsi->operationalState})
			{
				if (uc($_) eq "OK")
				{
					$status = OK;
					$count++;
				}
				elsif (uc($_) eq "ERROR")
				{
					$status = CRITICAL;
				}
				elsif (uc($_) eq "UNKNOWNSTATE")
				{
					$status = UNKNOWN;
				}
				elsif (uc($_) eq "OFF")
				{
					$status = CRITICAL;
				}
				elsif (uc($_) eq "QUIESCED")
				{
					$status = WARNING;
				}
				elsif (uc($_) eq "DEGRADED")
				{
					$status = WARNING;
				}
				elsif (uc($_) eq "LOSTCOMMUNICATION")
				{
					$status = CRITICAL;
				}
				else
				{
					$res = UNKNOWN;
					$status = UNKNOWN;
				}
				$state = Nagios::Plugin::Functions::max_state($state, $status);
			}
		}
		$np->add_perfdata(label => "LUNs", value => $count, uom => 'units', threshold => $np->threshold);
		$output .= $count . "/" . @{$storage->storageDeviceInfo->scsiLun} . " LUNs ok, ";

		if (exists($storage->storageDeviceInfo->{multipathInfo}))
		{
			$count = 0;
			my $amount = 0;
			foreach my $lun (@{$storage->storageDeviceInfo->multipathInfo->lun})
			{
				foreach my $path (@{$lun->path})
				{
					my $status = UNKNOWN; # For unkonwn or other statuses
					my $pathState = "unknown";
					if (exists($path->{state}))
					{
						$pathState = $path->state;
					}
					else
					{
						$pathState = $path->pathState;
					}

					$status = UNKNOWN;
					if (uc($pathState) eq "ACTIVE")
					{
						$status = OK;
						$count++;
					}
					elsif (uc($pathState) eq "DISABLED")
					{
						$status = WARNING;
					}
					elsif (uc($pathState) eq "STANDBY")
					{
						$status = WARNING;
					}
					elsif (uc($pathState) eq "DEAD")
					{
						$status = CRITICAL;
					}
					else
					{
						$res = UNKNOWN;
						$status = UNKNOWN;
					}
					$state = Nagios::Plugin::Functions::max_state($state, $status);
					$amount++;
				}
			}
			$np->add_perfdata(label => "paths", value => $count, uom => 'units', threshold => $np->threshold);
			$output .= $count . "/" . $amount . " paths active";
		}
		else
		{
			$output .= "no path info";
		}

		$res = $state if ($state != OK);
	}

	return ($res, $output);
}

sub format_uptime {
	my($uptime) = @_;

	my $days = $uptime / (60 * 60 * 24);
	$uptime %= (60 * 60 * 24);

	my $hours = $uptime / (60 * 60);
	$uptime %= (60 * 60);

	my $minutes = $uptime / 60;
	my $seconds = $uptime % 60;

	if ($days == 0)
	{
		$output = sprintf("%d:%02d:%02d", $hours, $minutes, $seconds);
	}
	elsif ($days == 1)
	{
		$output = sprintf("1 day, %d:%02d:%02d", $hours, $minutes, $seconds);
	}
	else {
		$output = sprintf("%d days, %d:%02d:%02d", $days, $hours, $minutes, $seconds);
	}

	return $output;
}

sub host_uptime_info
{
	my ($host, $np, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'HOST UPTIME Unknown error';

	my $quickStats;
	$quickStats = $addopts =~ m/(^|\s|\t|,)\Qquickstats\E($|\s|\t|,)/ if (defined($addopts));

	my $value;
	if (defined($quickStats))
	{
		my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime.inMaintenanceMode', 'summary.quickStats']);
		die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
		die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if (uc($host_view->get_property('runtime.inMaintenanceMode')) eq "TRUE");
		$values = $host_view->get_property('summary.quickStats');
		$value = simplify_number($values->uptime, 0) if exists($values->{uptime});
	}
	else
	{
		$values = return_host_performance_values($host, $defperfargs, 'sys', ('uptime.latest'));
		$value = simplify_number(convert_number($$values[0][0]->value), 0) if (defined($values));
	}
	if (defined($value))
	{
		$np->add_perfdata(label => "uptime", value => $value, uom => 's', threshold => $np->threshold);
		$output = "uptime=" . format_uptime($value);
		$res = $np->check_threshold(check => $value);
	}

	return ($res, $output);
}

sub host_device_info
{
	my ($host, $np, $subcommand, $addopts) = @_;

	my $count = 0;
	my $res = CRITICAL;
	my $output = 'HOST DEVICE Unknown error';

	if (defined($subcommand) && ($subcommand eq 'cd/dvd')) {
		my $host_view = Vim::find_entity_view(view_type => 'HostSystem', filter => $host, properties => ['name', 'runtime']);
		die "Host \"" . $$host{"name"} . "\" does not exist\n" if (!defined($host_view));
		die {msg => ("NOTICE: \"" . $host_view->name . "\" is in maintenance mode, check skipped\n"), code => OK} if ($host_view->runtime->inMaintenanceMode);

		my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $host_view, properties => ['name', 'config.template', 'config.hardware.device', 'runtime.powerState']);
		die "Runtime error\n" if (!defined($vm_views));

		my $listall;
		$listall = $addopts =~ m/(^|\s|\t|,)\Qlistall\E($|\s|\t|,)/ if (defined($addopts));

		$output = '';
		foreach my $vm (@$vm_views)
		{
			# change get_property to {} to avoid infinite loop
			my $istemplate = $vm->{'config.template'};
			next if ($istemplate && ($istemplate eq 'true'));
			my $match = 0;
			my $displayname = $vm->name;
			my $devices = $vm->{'config.hardware.device'};
			if ($subcommand eq 'cd/dvd') {
				foreach my $dev (@$devices) {
					$match++ if ((ref($dev) eq "VirtualCdrom") && ($dev->connectable->connected == 1));
				}
			}
			if ($match) {
				$count++;
				$output = "\"$displayname\"($match), " . $output;
			} else {
				$output .= "\"$displayname\"($match), " if ($listall);
			}
		}

		if ($output ne '') {
			chop($output);
			chop($output);
		}

		if ($count) {
			$output = "VM's with $subcommand devices: " . $output;
		} else {
			$output = $listall ? "VM's without $subcommand devices: " . $output : "No VM's with $subcommand devices";
		}

		$np->add_perfdata(label => "match", value => $count, threshold => $np->threshold);
		$res = $np->check_threshold(check => $count);
	} else {
		$res = CRITICAL;
		$output = "HOST DEVICE - unknown subcommand\n" . $np->opts->_help;
	}

	return ($res, $output);
}


#==========================================================================| VM |============================================================================#

sub vm_cpu_info
{
	my ($vmname, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST-VM CPU Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'cpu', ('usage.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) * 0.01);
				$np->add_perfdata(label => "cpu_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "\"$vmname\" cpu usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMHZ")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'cpu', ('usagemhz.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "cpu_usagemhz", value => $value, uom => 'MHz', threshold => $np->threshold);
				$output = "\"$vmname\" cpu usage=" . $value . " MHz";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "WAIT")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'cpu', ('wait.summation:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "cpu_wait", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "\"$vmname\" cpu wait=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "READY")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'cpu', ('ready.summation:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "cpu_ready", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "\"$vmname\" cpu ready=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST-VM CPU - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_host_vmware_performance_values($vmname, $defperfargs, 'cpu', ('usagemhz.average', 'usage.average', 'wait.summation:*', 'ready.summation:*'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value));
			my $value2 = simplify_number(convert_number($$values[0][1]->value) * 0.01);
			my $value3 = simplify_number(convert_number($$values[0][2]->value));
			my $value4 = simplify_number(convert_number($$values[0][3]->value));
			$np->add_perfdata(label => "cpu_usagemhz", value => $value1, uom => 'MHz', threshold => $np->threshold);
			$np->add_perfdata(label => "cpu_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$np->add_perfdata(label => "cpu_wait", value => $value3, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "cpu_ready", value => $value4, uom => 'ms', threshold => $np->threshold);
			$res = OK;
			$output = "\"$vmname\" cpu usage=" . $value1 . " MHz(" . $value2 . "%), wait=" . $value3 . " ms, ready=" . $value4 . " ms";
		}
	}

	return ($res, $output);
}

sub vm_mem_info
{
	my ($vmname, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST-VM MEM Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('usage.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) * 0.01);
				$np->add_perfdata(label => "mem_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "\"$vmname\" mem usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMB")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('consumed.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_usagemb", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" mem usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SWAP")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('swapped.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_swap", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" swap usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SWAPIN")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('swapin.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_swapin", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" swapin=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SWAPOUT")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('swapout.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_swapout", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" swapout=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "OVERHEAD")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('overhead.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_overhead", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" mem overhead=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "OVERALL")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('consumed.average', 'overhead.average'));
			if (defined($values))
			{
				my $value = simplify_number((convert_number($$values[0][0]->value) + convert_number($$values[0][1]->value)) / 1024);
				$np->add_perfdata(label => "mem_overall", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" mem overall=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "ACTIVE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('active.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_active", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" mem active=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "MEMCTL")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('vmmemctl.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_memctl", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" mem memctl=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST-VM MEM - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_host_vmware_performance_values($vmname, $defperfargs, 'mem', ('consumed.average', 'usage.average', 'overhead.average', 'active.average', 'swapped.average', 'swapin.average', 'swapout.average', 'vmmemctl.average'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value) / 1024);
			my $value2 = simplify_number(convert_number($$values[0][1]->value) * 0.01);
			my $value3 = simplify_number(convert_number($$values[0][2]->value) / 1024);
			my $value4 = simplify_number(convert_number($$values[0][3]->value) / 1024);
			my $value5 = simplify_number(convert_number($$values[0][4]->value) / 1024);
			my $value6 = simplify_number(convert_number($$values[0][5]->value) / 1024);
			my $value7 = simplify_number(convert_number($$values[0][6]->value) / 1024);
			my $value8 = simplify_number(convert_number($$values[0][7]->value) / 1024);
			$np->add_perfdata(label => "mem_usagemb", value => $value1, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_overhead", value => $value3, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_active", value => $value4, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_swap", value => $value5, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_swapin", value => $value6, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_swapout", value => $value7, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_memctl", value => $value8, uom => 'MB', threshold => $np->threshold);
			$res = OK;
			$output = "\"$vmname\" mem usage=" . $value1 . " MB(" . $value2 . "%), overhead=" . $value3 . " MB, active=" . $value4 . " MB, swapped=" . $value5 . " MB, swapin=" . $value6 . " MB, swapout=" . $value7 . " MB, memctl=" . $value8 . " MB";
		}
	}

	return ($res, $output);
}

sub vm_net_info
{
	my ($vmname, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST-VM NET Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'net', ('usage.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "net_usage", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "\"$vmname\" net usage=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "RECEIVE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'net', ('received.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "net_receive", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "\"$vmname\" net receive=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SEND")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'net', ('transmitted.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "net_send", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "\"$vmname\" net send=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST-VM NET - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_host_vmware_performance_values($vmname, $defperfargs, 'net', ('received.average:*', 'transmitted.average:*'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value));
			my $value2 = simplify_number(convert_number($$values[0][1]->value));
			$np->add_perfdata(label => "net_receive", value => $value1, uom => 'KBps', threshold => $np->threshold);
			$np->add_perfdata(label => "net_send", value => $value2, uom => 'KBps', threshold => $np->threshold);
			$res = OK;
			$output = "\"$vmname\" net receive=" . $value1 . " KBps, send=" . $value2 . " KBps";
		}
	}

	return ($res, $output);
}

sub vm_disk_io_info
{
	my ($vmname, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST-VM IO Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'disk', ('usage.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "io_usage", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "\"$vmname\" io usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "READ")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'disk', ('read.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "io_read", value => $value, uom => 'MB/s', threshold => $np->threshold);
				$output = "\"$vmname\" io read=" . $value . " MB/s";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "WRITE")
		{
			$values = return_host_vmware_performance_values($vmname, $defperfargs, 'disk', ('write.average:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "io_write", value => $value, uom => 'MB/s', threshold => $np->threshold);
				$output = "\"$vmname\" io write=" . $value . " MB/s";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST IO - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_host_vmware_performance_values($vmname, $defperfargs, 'disk', ('usage.average:*', 'read.average:*', 'write.average:*'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value) / 1024);
			my $value2 = simplify_number(convert_number($$values[0][1]->value) / 1024);
			my $value3 = simplify_number(convert_number($$values[0][2]->value) / 1024);
			$np->add_perfdata(label => "io_usage", value => $value1, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "io_read", value => $value2, uom => 'MB/s', threshold => $np->threshold);
			$np->add_perfdata(label => "io_write", value => $value3, uom => 'MB/s', threshold => $np->threshold);
			$res = OK;
			$output = "\"$vmname\" io usage=" . $value1 . " MB, read=" . $value2 . " MB/s, write=" . $value3 . " MB/s";
		}
	}

	return ($res, $output);
}

sub vm_runtime_info
{
	my ($vmname, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'HOST-VM RUNTIME Unknown error';
	my $runtime;
	my $vm_view = Vim::find_entity_view(view_type => 'VirtualMachine', filter => {name => $vmname}, properties => ['name', 'runtime', 'overallStatus', 'guest', 'configIssue']);
	die "VMware machine \"" . $vmname . "\" does not exist\n" if (!defined($vm_view));
	$runtime = $vm_view->runtime;

	if (defined($subcommand))
	{
		if ($subcommand eq "CON")
		{
			$output = "\"$vmname\" connection state=" . $runtime->connectionState->val;
			$res = OK if ($runtime->connectionState->val eq "connected");
		}
		elsif ($subcommand eq "CPU")
		{
			$output = "\"$vmname\" max cpu=" . $runtime->maxCpuUsage . " MHz";
			$res = OK;
		}
		elsif ($subcommand eq "MEM")
		{
			$output = "\"$vmname\" max mem=" . $runtime->maxMemoryUsage . " MB";
			$res = OK;
		}
		elsif ($subcommand eq "STATE")
		{
			my %vm_state_strings = ("poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED");
			my $state = $vm_state_strings{$runtime->powerState->val};
			$output = "\"$vmname\" run state=" . $state;
			$res = OK if ($state eq "UP");
		}
		elsif ($subcommand eq "STATUS")
		{
			my $status = $vm_view->overallStatus->val;
			$output = "\"$vmname\" overall status=" . $status;
			$res = check_health_state($status);
		}
		elsif ($subcommand eq "CONSOLECONNECTIONS")
		{
			$output = "\"$vmname\" console connections=" . $runtime->numMksConnections;
			$res = $np->check_threshold(check => $runtime->numMksConnections);
		}
		elsif ($subcommand eq "GUEST")
		{
			my %vm_guest_state = ("running" => "Running", "notRunning" => "Not running", "shuttingDown" => "Shutting down", "resetting" => "Resetting", "standby" => "Standby", "unknown" => "Unknown");
			my $state = $vm_guest_state{$vm_view->guest->guestState};
			$output = "\"$vmname\" guest state=" . $state;
			$res = OK if ($state eq "Running");
		}
		elsif ($subcommand eq "TOOLS")
		{
			my $tools_status;
			my $tools_runstate;
			my $tools_version;
			$tools_runstate = $vm_view->guest->toolsRunningStatus if (exists($vm_view->guest->{toolsRunningStatus}) && defined($vm_view->guest->toolsRunningStatus));
			$tools_version = $vm_view->guest->toolsVersionStatus if (exists($vm_view->guest->{toolsVersionStatus}) && defined($vm_view->guest->toolsVersionStatus));

			if (defined($tools_runstate) || defined($tools_version))
			{
				my %vm_tools_strings = ("guestToolsCurrent" => "Newest", "guestToolsNeedUpgrade" => "Old", "guestToolsNotInstalled" => "Not installed", "guestToolsUnmanaged" => "Unmanaged", "guestToolsExecutingScripts" => "Starting", "guestToolsNotRunning" => "Not running", "guestToolsRunning" => "Running");
				$tools_status = $vm_tools_strings{$tools_runstate} . "-" if (defined($tools_runstate));
				$tools_status .= $vm_tools_strings{$tools_version} . "-" if (defined($tools_version));
				chop($tools_status);
				$res = OK if (($tools_status eq "Running-Newest") || ($tools_status eq "Running-Unmanaged"));
			}
			else
			{
				my %vm_tools_strings = ("toolsNotInstalled" => "Not installed", "toolsNotRunning" => "Not running", "toolsOk" => "OK", "toolsOld" => "Old", "notDefined" => "Not defined");
				$tools_status = $vm_view->guest->toolsStatus;
				if (defined($tools_status))
				{
					$tools_status = $vm_tools_strings{$tools_status->val};
				}
				else
				{
					$tools_status = $vm_tools_strings{"notDefined"};
				}
				$res = OK if ($tools_status eq "OK");
			}
			$output = "\"$vmname\" tools status=" . $tools_status;
		}
		elsif ($subcommand eq "ISSUES")
		{
			my $issues = $vm_view->configIssue;

			if (defined($issues))
			{
				$output = "\"$vmname\": ";
				foreach (@$issues)
				{
					$output .= $_->fullFormattedMessage . "(caused by " . $_->userName . "); ";
				}
			}
			else
			{
				$res = OK;
				$output = "\"$vmname\" has no config issues";
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST-VM RUNTIME - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my %vm_state_strings = ("poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED");
		my %vm_tools_status = ("toolsNotInstalled" => "Not installed", "toolsNotRunning" => "Not running", "toolsOk" => "OK", "toolsOld" => "Old");
		my %vm_guest_state = ("running" => "Running", "notRunning" => "Not running", "shuttingDown" => "Shutting down", "resetting" => "Resetting", "standby" => "Standby", "unknown" => "Unknown");
		$res = OK;
		$output = "\"$vmname\" status=" . $vm_view->overallStatus->val . ", run state=" . $vm_state_strings{$runtime->powerState->val} . ", guest state=" . $vm_guest_state{$vm_view->guest->guestState} . ", max cpu=" . $runtime->maxCpuUsage . " MHz, max mem=" . $runtime->maxMemoryUsage . " MB, console connections=" . $runtime->numMksConnections . ", tools status=" . $vm_tools_status{$vm_view->guest->toolsStatus->val} . ", ";
		my $issues = $vm_view->configIssue;
		if (defined($issues))
		{
			$output .= @$issues . " config issue(s)";
		}
		else
		{
			$output .= "has no config issues";
		}
	}

	return ($res, $output);
}

#==========================================================================| DC |============================================================================#

sub return_cluster_DRS_recommendations {
	my ($np, $cluster_name) = @_;
	my $res = OK;
	my $output;
	my @clusters;

	if (defined($cluster_name))
	{
		my $cluster = Vim::find_entity_view(view_type => 'ClusterComputeResource', filter => $cluster_name, properties => ['name', 'recommendation']);
		die "cluster \"" . $$cluster_name{"name"} . "\" does not exist\n" if (!defined($cluster));
		push(@clusters, $cluster);
	}
	else
	{
		my $cluster = Vim::find_entity_views(view_type => 'ClusterComputeResource', properties => ['name', 'recommendation']);
		die "Runtime error\n" if (!defined($cluster));
		die "There are no clusters\n" if (!@$cluster);
		@clusters = @$cluster;
	}

	my $rec_count = 0;
	foreach my $cluster_view (@clusters)
	{
		my ($recommends) = $cluster_view->recommendation;
		if (defined($recommends))
		{
			my $value = 0;
			foreach my $recommend (@$recommends)
			{
				$value = $recommend->rating if ($recommend->rating > $value);
				$output .= "(" . $recommend->rating . ") " . $recommend->reason . " : " . $recommend->reasonText . "; ";
			}
			$rec_count += @$recommends;
			$res = $np->check_threshold(check => $value);
		}
	}

	if (defined($output))
	{
		$output = "Recommendations:" . $output;
	}
	else
	{
		$output = "No recommendations";
	}

	$np->add_perfdata(label => "recommendations", value => $rec_count);

	return ($res, $output);
}

sub dc_cpu_info
{
	my ($np, $subcommand, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'DC CPU Unknown error';

	my $quickStats;
	$quickStats = $addopts =~ m/(^|\s|\t|,)\Qquickstats\E($|\s|\t|,)/ if (defined($addopts));

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'summary.hardware', 'summary.quickStats']);
				die "Runtime error\n" if (!defined($host_views));
				die "Datacenter does not contain any hosts\n" if (!@$host_views);
				foreach my $host_view (@$host_views)
				{
					$values = $host_view->get_property('summary.quickStats');
					my $hardinfo = $host_view->get_property('summary.hardware');
					die "Can not retrieve required information from Host '" . $host_view->name . "'\n" if !(exists($values->{overallCpuUsage}) && defined($hardinfo));
					$value += $values->overallCpuUsage / ($hardinfo->numCpuCores * $hardinfo->cpuMhz) * 100;
				}
				$value = simplify_number($value / @$host_views);
			}
			else
			{
				$values = return_dc_performance_values($defperfargs, 'cpu',  ('usage.average'));
				grep($value += convert_number($$_[0]->value) * 0.01, @$values) if (defined($values));
				$value = simplify_number($value / @$values) if (defined($value));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "cpu_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "cpu usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMHZ")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'summary.quickStats']);
				die "Runtime error\n" if (!defined($host_views));
				die "Datacenter does not contain any hosts\n" if (!@$host_views);
				foreach my $host_view (@$host_views)
				{
					$values = $host_view->get_property('summary.quickStats');
					die "Can not retrieve required information from Host '" . $host_view->name . "'\n" if !(exists($values->{overallCpuUsage}));
					$value += $values->overallCpuUsage;
				}
				$value = simplify_number($value);
			}
			else
			{
				$values = return_dc_performance_values($defperfargs, 'cpu', ('usagemhz.average'));
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value) if (defined($value));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "cpu_usagemhz", value => $value, uom => 'MHz', threshold => $np->threshold);
				$output = "cpu usagemhz=" . $value . " MHz";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "DC CPU - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my $value1 = 0;
		my $value2 = 0;
		if (defined($quickStats))
		{
			my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'summary.hardware', 'summary.quickStats']);
			die "Runtime error\n" if (!defined($host_views));
			die "Datacenter does not contain any hosts\n" if (!@$host_views);
			foreach my $host_view (@$host_views)
			{
				$values = $host_view->get_property('summary.quickStats');
				my $hardinfo = $host_view->get_property('summary.hardware');
				die "Can not retrieve required information from Host '" . $host_view->name . "'\n" if !(exists($values->{overallCpuUsage}) && defined($hardinfo));
				$value1 += $values->overallCpuUsage;
				$value2 += $values->overallCpuUsage / ($hardinfo->numCpuCores * $hardinfo->cpuMhz) * 100;
			}
			$value1 = simplify_number($value1);
			$value2 = simplify_number($value2 / @$host_views);
		}
		else
		{
			$values = return_dc_performance_values($defperfargs, 'cpu', ('usagemhz.average', 'usage.average'));
			grep($value1 += convert_number($$_[0]->value), @$values);
			grep($value2 += convert_number($$_[1]->value) * 0.01, @$values);
			$value1 = simplify_number($value1);
			$value2 = simplify_number($value2 / @$values);
		}
		if (defined($value1) && defined($value2))
		{
			$np->add_perfdata(label => "cpu_usagemhz", value => $value1, uom => 'MHz', threshold => $np->threshold);
			$np->add_perfdata(label => "cpu_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$res = OK;
			$output = "cpu usage=" . $value1 . " MHz (" . $value2 . "%)";
		}
	}

	return ($res, $output);
}

sub dc_mem_info
{
	my ($np, $subcommand, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'DC MEM Unknown error';

	my $quickStats;
	$quickStats = $addopts =~ m/(^|\s|\t|,)\Qquickstats\E($|\s|\t|,)/ if (defined($addopts));

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'summary.hardware', 'summary.quickStats']);
				die "Runtime error\n" if (!defined($host_views));
				die "Datacenter does not contain any hosts\n" if (!@$host_views);
				foreach my $host_view (@$host_views)
				{
					$values = $host_view->get_property('summary.quickStats');
					my $hardinfo = $host_view->get_property('summary.hardware');
					die "Can not retrieve required information from Host '" . $host_view->name . "'\n" if !(exists($values->{overallMemoryUsage}) && defined($hardinfo));
					$value += $values->overallMemoryUsage / ($hardinfo->memorySize / 1024 / 1024) * 100;
				}
				$value = simplify_number($value);
			}
			else
			{
				$values = return_dc_performance_values($defperfargs, 'mem', ('usage.average'));
				grep($value += convert_number($$_[0]->value) * 0.01, @$values);
				$value = simplify_number($value / @$values) if (defined($value));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "mem_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "mem usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMB")
		{
			my $value;
			if (defined($quickStats))
			{
				my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'summary.quickStats']);
				die "Runtime error\n" if (!defined($host_views));
				die "Datacenter does not contain any hosts\n" if (!@$host_views);
				foreach my $host_view (@$host_views)
				{
					$values = $host_view->get_property('summary.quickStats');
					die "Can not retrieve required information from Host '" . $host_view->name . "'\n" if !(exists($values->{overallMemoryUsage}));
					$value += $values->overallMemoryUsage;
				}
				$value = simplify_number($value);
			}
			else
			{
				$values = return_dc_performance_values($defperfargs, 'mem', ('consumed.average'));
				grep($value += convert_number($$_[0]->value) / 1024, @$values);
				$value = simplify_number($value) if (defined($value));
			}
			if (defined($value))
			{
				$np->add_perfdata(label => "mem_usagemb", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "mem usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SWAP")
		{
			$values = return_dc_performance_values($defperfargs, 'mem', ('swapused.average'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value) / 1024, @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "mem_swap", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "swap usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "OVERHEAD")
		{
			$values = return_dc_performance_values($defperfargs, 'mem', ('overhead.average'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value) / 1024, @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "mem_overhead", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "overhead=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "OVERALL")
		{
			$values = return_dc_performance_values($defperfargs, 'mem', ('consumed.average', 'overhead.average'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += (convert_number($$_[0]->value) + convert_number($$_[1]->value)) / 1024, @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "mem_overall", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "overall=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "MEMCTL")
		{
			$values = return_dc_performance_values($defperfargs, 'mem', ('vmmemctl.average'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value) / 1024, @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "mem_memctl", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "memctl=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "DC MEM - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_dc_performance_values($defperfargs, 'mem', ('consumed.average', 'usage.average', 'overhead.average', 'swapused.average', 'vmmemctl.average'));
		if (defined($values))
		{
			my $value1 = 0;
			my $value2 = 0;
			my $value3 = 0;
			my $value4 = 0;
			my $value5 = 0;
			grep($value1 += convert_number($$_[0]->value) / 1024, @$values);
			grep($value2 += convert_number($$_[1]->value) * 0.01, @$values);
			grep($value3 += convert_number($$_[2]->value) / 1024, @$values);
			grep($value4 += convert_number($$_[3]->value) / 1024, @$values);
			grep($value5 += convert_number($$_[4]->value) / 1024, @$values);
			$value1 = simplify_number($value1);
			$value2 = simplify_number($value2 / @$values);
			$value3 = simplify_number($value3);
			$value4 = simplify_number($value4);
			$value5 = simplify_number($value5);
			$np->add_perfdata(label => "mem_usagemb", value => $value1, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_overhead", value => $value3, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_swap", value => $value4, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_memctl", value => $value5, uom => 'MB', threshold => $np->threshold);
			$res = OK;
			$output = "mem usage=" . $value1 . " MB (" . $value2 . "%), overhead=" . $value3 . " MB, swapped=" . $value4 . " MB, memctl=" . $value5 . " MB";
		}
	}

	return ($res, $output);
}

sub dc_net_info
{
	my ($np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'DC NET Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_dc_performance_values($defperfargs, 'net', ('usage.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "net_usage", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "net usage=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "RECEIVE")
		{
			$values = return_dc_performance_values($defperfargs, 'net', ('received.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "net_receive", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "net receive=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SEND")
		{
			$values = return_dc_performance_values($defperfargs, 'net', ('transmitted.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value);
				$np->add_perfdata(label => "net_send", value => $value, uom => 'KBps', threshold => $np->threshold);
				$output = "net send=" . $value . " KBps";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "DC NET - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_dc_performance_values($defperfargs, 'net', ('received.average:*', 'transmitted.average:*'));
		if (defined($values))
		{
			my $value1 = 0;
			my $value2 = 0;
			grep($value1 += convert_number($$_[0]->value), @$values);
			grep($value2 += convert_number($$_[1]->value), @$values);
			$value1 = simplify_number($value1);
			$value2 = simplify_number($value2);
			$np->add_perfdata(label => "net_receive", value => $value1, uom => 'KBps', threshold => $np->threshold);
			$np->add_perfdata(label => "net_send", value => $value2, uom => 'KBps', threshold => $np->threshold);
			$res = OK;
			$output = "net receive=" . $value1 . " KBps, send=" . $value2 . " KBps";
		}
	}

	return ($res, $output);
}

sub dc_list_vm_volumes_info
{
	my ($np, $subcommand, $blacklist, $perc, $addopts) = @_;

	my $dc_views = Vim::find_entity_views(view_type => 'Datacenter', properties => ['datastore']);
	die "There are no Datacenter\n" if (!defined($dc_views));

	my @datastores;
	foreach my $dc (@$dc_views)
	{
		push(@datastores, @{$dc->datastore}) if (defined($dc->datastore));
	}

	return datastore_volumes_info(\@datastores, $np, $subcommand, $blacklist, $perc, $addopts);
}

sub dc_disk_io_info
{
	my ($np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'DC IO Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "ABORTED")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('commandsAborted.summation:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_aborted", value => $value, threshold => $np->threshold);
				$output = "io commands aborted=" . $value;
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "RESETS")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('busResets.summation:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_busresets", value => $value, threshold => $np->threshold);
				$output = "io bus resets=" . $value;
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "READ")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('totalReadLatency.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_read", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io read latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "WRITE")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('totalWriteLatency.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_write", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io write latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "KERNEL")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('kernelLatency.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_kernel", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io kernel latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "DEVICE")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('deviceLatency.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_device", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io device latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "QUEUE")
		{
			$values = return_dc_performance_values($defperfargs, 'disk', ('queueLatency.average:*'));
			if (defined($values))
			{
				my $value = 0;
				grep($value += convert_number($$_[0]->value), @$values);
				$value = simplify_number($value, 0);
				$np->add_perfdata(label => "io_queue", value => $value, uom => 'ms', threshold => $np->threshold);
				$output = "io queue latency=" . $value . " ms";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "DC IO - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_dc_performance_values($defperfargs, 'disk', ('commandsAborted.summation:*', 'busResets.summation:*', 'totalReadLatency.average:*', 'totalWriteLatency.average:*', 'kernelLatency.average:*', 'deviceLatency.average:*', 'queueLatency.average:*'));
		if (defined($values))
		{
			my $value1 = 0;
			my $value2 = 0;
			my $value3 = 0;
			my $value4 = 0;
			my $value5 = 0;
			my $value6 = 0;
			my $value7 = 0;
			grep($value1 += convert_number($$_[0]->value), @$values);
			grep($value2 += convert_number($$_[1]->value), @$values);
			grep($value3 += convert_number($$_[2]->value), @$values);
			grep($value4 += convert_number($$_[3]->value), @$values);
			grep($value5 += convert_number($$_[4]->value), @$values);
			grep($value6 += convert_number($$_[5]->value), @$values);
			grep($value7 += convert_number($$_[6]->value), @$values);
			$value1 = simplify_number($value1, 0);
			$value2 = simplify_number($value2, 0);
			$value3 = simplify_number($value3, 0);
			$value4 = simplify_number($value4, 0);
			$value5 = simplify_number($value5, 0);
			$value6 = simplify_number($value6, 0);
			$value7 = simplify_number($value7, 0);
			$np->add_perfdata(label => "io_aborted", value => $value1, threshold => $np->threshold);
			$np->add_perfdata(label => "io_busresets", value => $value2, threshold => $np->threshold);
			$np->add_perfdata(label => "io_read", value => $value3, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_write", value => $value4, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_kernel", value => $value5, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_device", value => $value6, uom => 'ms', threshold => $np->threshold);
			$np->add_perfdata(label => "io_queue", value => $value7, uom => 'ms', threshold => $np->threshold);
			$res = OK;
			$output = "io commands aborted=" . $value1 . ", io bus resets=" . $value2 . ", io read latency=" . $value3 . " ms, write latency=" . $value4 . " ms, kernel latency=" . $value5 . " ms, device latency=" . $value6 . " ms, queue latency=" . $value7 ." ms";
		}
	}

	return ($res, $output);
}

sub dc_runtime_info
{
	my ($np, $subcommand, $blacklist) = @_;

	my $res = CRITICAL;
	my $output = 'DC RUNTIME Unknown error';
	my $runtime;

	if (defined($subcommand))
	{
		if (($subcommand eq "LIST") || ($subcommand eq "LISTVM"))
		{
			my %vm_state_strings = ("poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED");
			my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', properties => ['name', 'runtime']);
			die "Runtime error\n" if (!defined($vm_views));
			die "There are no VMs.\n" if (!@$vm_views);
			my $up = 0;
			$output = '';

			foreach my $vm (@$vm_views) {
				my $vm_state = $vm_state_strings{$vm->runtime->powerState->val};
				if ($vm_state eq "UP")
				{
					$up++;
					$output .= $vm->name . "(UP), ";
				}
				else
				{
					$output = $vm->name . "(" . $vm_state . "), " . $output;
				}
			}

			chop($output);
			chop($output);
			$res = OK;
			$output = $up . "/" . @$vm_views . " VMs up: " . $output;
			$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);
			$res = $np->check_threshold(check => $up) if (defined($np->threshold));
		}
		elsif ($subcommand eq "LISTHOST")
		{
			my %host_state_strings = ("unknown" => "UNKNOWN", "poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED", "standBy" => "STANDBY", "MaintenanceMode" => "Maintenance Mode");
			my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'runtime.powerState']);
			die "Runtime error\n" if (!defined($host_views));
			die "There are no VMs.\n" if (!@$host_views);
			my $up = 0;
			my $unknown = 0;
			$output = '';

			foreach my $host (@$host_views) {
				$host->update_view_data(['name', 'runtime.powerState']);
				my $host_state = $host_state_strings{$host->get_property('runtime.powerState')->val};
				$unknown += $host_state eq "UNKNOWN";
				if ($host_state eq "UP") {
					$up++;
					$output .= $host->name . "(UP), ";
				}
				else
				{
					$output = $host->name . "(" . $host_state . "), " . $output;
				}
			}

			chop($output);
			chop($output);
			$res = OK;
			$output = $up . "/" . @$host_views . " Hosts up: " . $output;
			$np->add_perfdata(label => "hostcount", value => $up, uom => 'units', threshold => $np->threshold);
			$res = $np->check_threshold(check => $up) if (defined($np->threshold));
			$res = UNKNOWN if ($res == OK && $unknown);
		}
		elsif ($subcommand eq "LISTCLUSTER")
		{
			my %cluster_state_strings = ("gray" => "UNKNOWN", "green" => "GREEN", "red" => "RED", "yellow" => "YELLOW");
			my $cluster_views = Vim::find_entity_views(view_type => 'ClusterComputeResource', properties => ['name', 'overallStatus']);
			die "Runtime error\n" if (!defined($cluster_views));
			die "There are no Clusters.\n" if (!@$cluster_views);
			my $green = 0;
			my $unknown = 0;
			$output = '';

			foreach my $cluster (@$cluster_views) {
				$cluster->update_view_data(['name', 'overallStatus']);
				my $cluster_state = $cluster_state_strings{$cluster->get_property('overallStatus')->val};
				$unknown += $cluster_state eq "UNKNOWN";
				if ($cluster_state eq "GREEN") {
					$green++;
					$output .= $cluster->name . "(GREEN), ";
				}
				else
				{
					$output = $cluster->name . "(" . $cluster_state . "), " . $output;
				}
			}

			chop($output);
			chop($output);
			$res = OK;
			$output = $green . "/" . @$cluster_views . " Cluster green: " . $output;
			$np->add_perfdata(label => "clustercount", value => $green, uom => 'units', threshold => $np->threshold);
			$res = $np->check_threshold(check => $green) if (defined($np->threshold));
			$res = UNKNOWN if ($res == OK && $unknown);
		}
		elsif ($subcommand eq "TOOLS")
		{
			my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', properties => ['name', 'runtime.powerState', 'summary.guest']);
			die "Runtime error\n" if (!defined($vm_views));
			die "There are no VMs.\n" if (!@$vm_views);
			$output = '';
			my $tools_ok = 0;
			my $vms_up = 0;
			foreach my $vm (@$vm_views) {
				my $name = $vm->name;
				if (defined($blacklist))
				{
					next if ($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
				}
				if ($vm->get_property('runtime.powerState')->val eq "poweredOn")
				{
					my $vm_guest = $vm->get_property('summary.guest');
					my $tools_status;
					my $tools_runstate;
					my $tools_version;
					$tools_runstate = $vm_guest->toolsRunningStatus if (exists($vm_guest->{toolsRunningStatus}) && defined($vm_guest->toolsRunningStatus));
					$tools_version = $vm_guest->toolsVersionStatus if (exists($vm_guest->{toolsVersionStatus}) && defined($vm_guest->toolsVersionStatus));

					$vms_up++;
					if (defined($tools_runstate) || defined($tools_version))
					{
						my %vm_tools_strings = ("guestToolsCurrent" => "Newest", "guestToolsNeedUpgrade" => "Old", "guestToolsNotInstalled" => "Not installed", "guestToolsUnmanaged" => "Unmanaged", "guestToolsExecutingScripts" => "Starting", "guestToolsNotRunning" => "Not running", "guestToolsRunning" => "Running");
						$tools_status = $vm_tools_strings{$tools_runstate} . "-" if (defined($tools_runstate));
						$tools_status .= $vm_tools_strings{$tools_version} . "-" if (defined($tools_version));
						chop($tools_status);
						if ($tools_status eq "Running-Newest")
						{
							$output .= $name . "(Running-Newest), ";
							$tools_ok++;
						}
						else
						{
							$output = $name . "(" . $tools_status . "), " . $output;
						}
					}
					else
					{
						my %vm_tools_strings = ("toolsNotInstalled" => "Not installed", "toolsNotRunning" => "Not running", "toolsOk" => "OK", "toolsOld" => "Old", "notDefined" => "Not defined");
						$tools_status = $vm_guest->toolsStatus;
						if (defined($tools_status))
						{
							$tools_status = $vm_tools_strings{$tools_status->val};
							if ($tools_status eq "OK")
							{
								$output .= $name . "(OK), ";
								$tools_ok++;
							}
							else
							{
								$output = $name . "(" . $tools_status . "), " . $output;
							}
						}
						else
						{
							$output = $name . "(" . $vm_tools_strings{"notDefined"} . "), " . $output;
						}
					}
				}
			}
			chop($output);
			chop($output);
			if ($vms_up)
			{
				$tools_ok /= $vms_up / 100;
			}
			else
			{
				$tools_ok = 100;
			}
			$res = $np->check_threshold(check => $tools_ok) if (defined($np->threshold));
			$np->add_perfdata(label => "toolsok", value => $tools_ok, uom => '%', threshold => $np->threshold);
		}
		elsif ($subcommand eq "STATUS")
		{
			my $dc_views = Vim::find_entity_views(view_type => 'Datacenter', properties => ['name', 'overallStatus']);
			die "There are no Datacenter\n" if (!defined($dc_views));

			$res = OK;
			$output = '';
			foreach my $dc (@$dc_views) {
				if (defined($dc->overallStatus))
				{
					my $status = $dc->overallStatus->val;
					$output .= $dc->name . " overall status=" . $status . ", ";
					$status = check_health_state($status);
					$res = UNKNOWN if ($status == UNKNOWN);
					$res = Nagios::Plugin::Functions::max_state($res, $status) if (($res != UNKNOWN) || ($status != OK));
				}
				else
				{
					$output .= "Insufficient rights to access " . $dc->name . " status info on the DC, ";
					$res = Nagios::Plugin::Functions::max_state($res, WARNING);
				}
			}
			if ($output) {
				chop($output);
				chop($output);
			}
		}
		elsif ($subcommand eq "ISSUES")
		{
			my $dc_views = Vim::find_entity_views(view_type => 'Datacenter', properties => ['name', 'configIssue']);
			die "There are no Datacenter\n" if (!defined($dc_views));

			my $issues_count = 0;
			$output = '';

			foreach my $dc (@$dc_views) {
				my $issues = $dc->configIssue;

				if (defined($issues))
				{
					foreach (@$issues)
					{
						if (defined($blacklist))
						{
							my $name = ref($_);
							next if ($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
						}
						$output .= format_issue($_) . "(" . $dc->name . "); ";
						$issues_count++;
					}
				}
			}

			if ($output eq '')
			{
				$res = OK;
				$output = 'No config issues';
			}
			$np->add_perfdata(label => "issues", value => $issues_count);
		}
		else
		{
			$res = CRITICAL;
			$output = "HOST RUNTIME - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my $dc_views = Vim::find_entity_views(view_type => 'Datacenter', properties => ['name', 'overallStatus', 'configIssue']);
		die "There are no Datacenter\n" if (!defined($dc_views));
		my %host_maintenance_state = (0 => "no", 1 => "yes");
		my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', properties => ['name', 'runtime.powerState', 'config.template']);
		die "Runtime error\n" if (!defined($vm_views));
		my $up = 0;
		my $templ = 0;

		if (@$vm_views)
		{
			my $totalvms = @$vm_views;
			foreach my $vm (@$vm_views) {
				$up += $vm->get_property('runtime.powerState')->val eq "poweredOn";
				$templ += $vm->{'config.template'} eq "true";
			}
			$totalvms -= $templ;
			$output = $up . "/" . $totalvms . " VMs up (" . $templ . " templates), ";
		}
		else
		{
			$output = "No VMs installed, ";
		}
		$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);

		my $host_views = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name', 'runtime.powerState']);
		die "Runtime error\n" if (!defined($host_views));
		$up = 0;

		if (@$host_views)
		{
			foreach my $host (@$host_views) {
				$up += $host->get_property('runtime.powerState')->val eq "poweredOn"
			}
			$output .= $up . "/" . @$host_views . " Hosts up, ";
		}
		else
		{
			$output .= "there are no hosts, ";
		}
		$np->add_perfdata(label => "hostcount", value => $up, uom => 'units');

		$res = OK;

		foreach my $dc (@$dc_views) {
			$output .= $dc->name . " overall status=" . $dc->overallStatus->val . ", " if (defined($dc->overallStatus));
		}

		my $issue_count = 0;
		foreach my $dc (@$dc_views) {
			my $issues = $dc->configIssue;
			$issue_count += @$issues if (defined($issues));
		}

		if ($issue_count)
		{
			$output .= $issue_count . " config issue(s)";
			$np->add_perfdata(label => "config_issues", value => $issue_count);
		}
		else
		{
			$output .= "no config issues";
			$np->add_perfdata(label => "config_issues", value => 0);
		}
	}

	return ($res, $output);
}

#=====================================================================| Cluster |============================================================================#

sub cluster_cpu_info
{
	my ($cluster, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'CLUSTER CPU Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'cpu', ('usage.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) * 0.01);
				$np->add_perfdata(label => "cpu_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "cpu usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMHZ")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'cpu', ('usagemhz.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "cpu_usagemhz", value => $value, uom => 'MHz', threshold => $np->threshold);
				$output = "cpu usagemhz=" . $value . " MHz";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "CLUSTER CPU - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_cluster_performance_values($cluster, $defperfargs, 'cpu', ('usagemhz.average', 'usage.average'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value));
			my $value2 = simplify_number(convert_number($$values[0][1]->value) * 0.01);
			$np->add_perfdata(label => "cpu_usagemhz", value => $value1, uom => 'MHz', threshold => $np->threshold);
			$np->add_perfdata(label => "cpu_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$res = OK;
			$output = "cpu usage=" . $value1 . " MHz (" . $value2 . "%)";
		}
	}

	return ($res, $output);
}

sub cluster_mem_info
{
	my ($cluster, $np, $subcommand, $addopts) = @_;

	my $res = CRITICAL;
	my $output = 'CLUSTER MEM Unknown error';

	my $outputlist;
	$outputlist = $addopts =~ m/(^|\s|\t|,)\Qlistvm\E($|\s|\t|,)/ if (defined($addopts));

	if (defined($subcommand))
	{
		if ($subcommand eq "USAGE")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'mem', ('usage.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) * 0.01);
				$np->add_perfdata(label => "mem_usage", value => $value, uom => '%', threshold => $np->threshold);
				$output = "mem usage=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "USAGEMB")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'mem', ('consumed.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_usagemb", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "mem usage=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "SWAP")
		{
			my $cluster_view;
			($cluster_view, $values) = return_cluster_performance_values($cluster, $defperfargs, 'mem', ('swapused.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_swap", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "swap usage=" . $value . " MB: ";
				$res = $np->check_threshold(check => $value);
				if ($res != OK && $outputlist)
				{
					my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $$cluster_view[0], properties => ['name', 'runtime.powerState']);
					die "Runtime error\n" if (!defined($vm_views));
					die "There are no VMs.\n" if (!@$vm_views);
					my @vms = ();
					foreach my $vm (@$vm_views)
					{
						push(@vms, $vm) if ($vm->get_property('runtime.powerState')->val eq "poweredOn");
					}
					$values = generic_performance_values(\@vms, $defperfargs, 'mem', ('swapped.average'));
					if (defined($values))
					{
						foreach my $index (0..@vms-1) {
							my $value = simplify_number(convert_number($$values[$index][0]->value) / 1024);
							$output .= $vms[$index]->name . " (" . $value . "MB), " if ($value > 0);
						}
					}
				}
				chop($output);
				chop($output);
			}
		}
		elsif ($subcommand eq "MEMCTL")
		{
			my $cluster_view;
			($cluster_view, $values) = return_cluster_performance_values($cluster, $defperfargs, 'mem', ('vmmemctl.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "mem_memctl", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "memctl=" . $value . " MB: ";
				$res = $np->check_threshold(check => $value);
				if ($res != OK && $outputlist)
				{
					my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $$cluster_view[0], properties => ['name', 'runtime.powerState']);
					die "Runtime error\n" if (!defined($vm_views));
					die "There are no VMs.\n" if (!@$vm_views);
					my @vms = ();
					foreach my $vm (@$vm_views)
					{
						push(@vms, $vm) if ($vm->get_property('runtime.powerState')->val eq "poweredOn");
					}
					$values = generic_performance_values(\@vms, $defperfargs, 'mem', ('vmmemctl.average'));
					if (defined($values))
					{
						foreach my $index (0..@vms-1) {
							my $value = simplify_number(convert_number($$values[$index][0]->value) / 1024);
							$output .= $vms[$index]->name . " (" . $value . "MB), " if ($value > 0);
						}
					}
				}
				chop($output);
				chop($output);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "CLUSTER MEM - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_cluster_performance_values($cluster, $defperfargs, 'mem', ('consumed.average', 'usage.average', 'overhead.average', 'swapused.average', 'vmmemctl.average'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value) / 1024);
			my $value2 = simplify_number(convert_number($$values[0][1]->value) * 0.01);
			my $value3 = simplify_number(convert_number($$values[0][2]->value) / 1024);
			my $value4 = simplify_number(convert_number($$values[0][3]->value) / 1024);
			my $value5 = simplify_number(convert_number($$values[0][4]->value) / 1024);
			$np->add_perfdata(label => "mem_usagemb", value => $value1, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_usage", value => $value2, uom => '%', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_overhead", value => $value3, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_swap", value => $value4, uom => 'MB', threshold => $np->threshold);
			$np->add_perfdata(label => "mem_memctl", value => $value5, uom => 'MB', threshold => $np->threshold);
			$res = OK;
			$output = "mem usage=" . $value1 . " MB (" . $value2 . "%), overhead=" . $value3 . " MB, swapped=" . $value4 . " MB, memctl=" . $value5 . " MB";
		}
	}

	return ($res, $output);
}

sub cluster_cluster_info
{
	my ($cluster, $np, $subcommand) = @_;

	my $res = CRITICAL;
	my $output = 'CLUSTER clusterServices Unknown error';

	if (defined($subcommand))
	{
		if ($subcommand eq "EFFECTIVECPU")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'clusterServices', ('effectivecpu.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) * 0.01);
				$np->add_perfdata(label => "effective cpu", value => $value, uom => 'MHz', threshold => $np->threshold);
				$output = "effective cpu=" . $value . " MHz";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "EFFECTIVEMEM")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'clusterServices', ('effectivemem.average'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value) / 1024);
				$np->add_perfdata(label => "effectivemem", value => $value, uom => 'MB', threshold => $np->threshold);
				$output = "effective mem=" . $value . " MB";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "FAILOVER")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'clusterServices', ('failover.latest:*'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "failover", value => $value, threshold => $np->threshold);
				$output = "failover=" . $value . " ";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "CPUFAIRNESS")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'clusterServices', ('cpufairness.latest'));
			if (defined($values))
			{
				my $value = simplify_number(convert_number($$values[0][0]->value));
				$np->add_perfdata(label => "cpufairness", value => $value, uom => '%', threshold => $np->threshold);
				$output = "cpufairness=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		elsif ($subcommand eq "MEMFAIRNESS")
		{
			$values = return_cluster_performance_values($cluster, $defperfargs, 'clusterServices', ('memfairness.latest'));
			if (defined($values))
			{
				my $value = simplify_number((convert_number($$values[0][0]->value)));
				$np->add_perfdata(label => "memfairness", value =>  $value, uom => '%', threshold => $np->threshold);
				$output = "memfairness=" . $value . " %";
				$res = $np->check_threshold(check => $value);
			}
		}
		else
		{
			$res = CRITICAL;
			$output = "CLUSTER clusterServices - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		$values = return_cluster_performance_values($cluster, $defperfargs, 'clusterServices', ('effectivecpu.average', 'effectivemem.average'));
		if (defined($values))
		{
			my $value1 = simplify_number(convert_number($$values[0][0]->value));
			my $value2 = simplify_number(convert_number($$values[0][1]->value) / 1024);
			$np->add_perfdata(label => "effective cpu", value => $value1, uom => 'MHz', threshold => $np->threshold);
			$np->add_perfdata(label => "effective mem", value => $value2, uom => 'MB', threshold => $np->threshold);
			$res = OK;
			$output = "effective cpu=" . $value1 . " MHz, effective Mem=" . $value2 . " MB";
		}
	}

	return ($res, $output);
}

sub cluster_runtime_info
{
	my ($cluster, $np, $subcommand, $blacklist) = @_;

	my $res = CRITICAL;
	my $output = 'CLUSTER RUNTIME Unknown error';
	my $runtime;
	my $cluster_view = Vim::find_entity_view(view_type => 'ClusterComputeResource', filter => { name => "$cluster" }, properties => ['name', 'overallStatus', 'configIssue']);
	die "Cluster \"" . $$cluster{"name"} . "\" does not exist\n" if (!defined($cluster_view));
	$cluster_view->update_view_data();

	if (defined($subcommand))
	{
		if (($subcommand eq "LIST") || ($subcommand eq "LISTVM"))
		{
			my %vm_state_strings = ("poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED");
			my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $cluster_view, properties => ['name', 'runtime']);
			die "Runtime error\n" if (!defined($vm_views));
			die "There are no VMs.\n" if (!defined($vm_views));
			my $up = 0;
			$output = '';

			foreach my $vm (@$vm_views)
			{
				my $vm_state = $vm_state_strings{$vm->runtime->powerState->val};
				if ($vm_state eq "UP")
				{
					$up++;
					$output .= $vm->name . "(OK), ";
				}
				else
				{
					$output = $vm->name . "(" . $vm_state . "), " . $output;
				}
			}

			chop($output);
			chop($output);
			$res = OK;
			$output = $up .  "/" . @$vm_views . " VMs up: " . $output;
			$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);
			$res = $np->check_threshold(check => $up) if (defined($np->threshold));
		}
		elsif ($subcommand eq "LISTHOST")
		{
			my %host_state_strings = ("poweredOn" => "UP", "poweredOff" => "DOWN", "suspended" => "SUSPENDED", "standBy" => "STANDBY", "MaintenanceMode" => "Maintenance Mode");
			my $host_views = Vim::find_entity_views(view_type => 'HostSystem', begin_entity => $cluster_view, properties => ['name', 'runtime.powerState']);
			die "Runtime error\n" if (!defined($host_views));
			die "There are no hosts.\n" if (!defined($host_views));
			my $up = 0;
			my $unknown = 0;
			$output = '';

			foreach my $host (@$host_views) {
				$host->update_view_data(['name', 'runtime.powerState']);
				my $host_state = $host_state_strings{$host->get_property('runtime.powerState')->val};
				$unknown += $host_state eq "UNKNOWN";
				if ($host_state eq "UP" ) {
					$up++;
					$output .= $host->name . "(UP), ";
				}
				else {
					$output = $host->name . "(" . $host_state . "), " . $output;
				}
			}

			chop($output);
			chop($output);
			$res = OK;
			$output = $up .  "/" . @$host_views . " Hosts up: " . $output;
			$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);
			$res = $np->check_threshold(check => $up) if (defined($np->threshold));
			$res = UNKNOWN if ($res == OK && $unknown);
		}
		elsif ($subcommand eq "STATUS")
		{
			if (defined($cluster_view->overallStatus))
			{
				my $status = $cluster_view->overallStatus->val;
				$output = "overall status=" . $status;
				$res = check_health_state($status);
			}
			else
			{
				$output = "Insufficient rights to access status info on the DC\n";
				$res = WARNING;
			}
		}
		elsif ($subcommand eq "ISSUES")
		{
			my $issues = $cluster_view->configIssue;
			my $issues_count = 0;

			$output = '';
			if (defined($issues))
			{
				foreach (@$issues)
				{
					if (defined($blacklist))
					{
						my $name = ref($_);
						next if ($blacklist =~ m/(^|\s|\t|,)\Q$name\E($|\s|\t|,)/);
					}
					$output .= format_issue($_) . "; ";
					$issues_count++;
				}
			}

			if ($output eq '')
			{
				$res = OK;
				$output = 'No config issues';
			}
			$np->add_perfdata(label => "issues", value => $issues_count);
		}
		else
		{
			$res = CRITICAL;
			$output = "CLUSTER RUNTIME - unknown subcommand\n" . $np->opts->_help;
		}
	}
	else
	{
		my %cluster_maintenance_state = (0 => "no", 1 => "yes");
		my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine', begin_entity => $cluster_view, properties => ['name', 'runtime.powerState']);
		my $up = 0;

		if (defined($vm_views))
		{
			foreach my $vm (@$vm_views) {
				$up += $vm->get_property('runtime.powerState')->val eq "poweredOn";
			}
			$np->add_perfdata(label => "vmcount", value => $up, uom => 'units', threshold => $np->threshold);
			$output = $up . "/" . @$vm_views . " VMs up";
		}
		else
		{
			$output = "No VMs installed";
		}

		my $AlertCount = 0;
		my $SensorCount = 0;
		my ($cpuStatusInfo, $storageStatusInfo, $memoryStatusInfo, $numericSensorInfo);

		$res = OK;

		if (defined($cluster_view->overallStatus))
		{
			my $overallstatus = $cluster_view->overallStatus->val;
			$res = check_health_state($overallstatus);
			$output .= ", overall status=" . $overallstatus . ", ";
		}

		my $issues = $cluster_view->configIssue;
		if (defined($issues))
		{
			$output .= @$issues . " config issue(s)";
			$res = WARNING if ($res == OK);
		}
		else
		{
			$output .= "no config issues";
		}
	}

	return ($res, $output);
}

sub cluster_list_vm_volumes_info
{
	my ($cluster, $np, $subcommand, $blacklist, $perc, $addopts) = @_;

	my $cluster_view = Vim::find_entity_view(view_type => 'ClusterComputeResource', filter => {name => "$cluster"}, properties => ['name', 'datastore']);
	die "Insufficient rights to access Datastores on the Host\n" if (!defined($cluster_view->datastore));

	return datastore_volumes_info($cluster_view->datastore, $np, $subcommand, $blacklist, $perc, $addopts);
}
