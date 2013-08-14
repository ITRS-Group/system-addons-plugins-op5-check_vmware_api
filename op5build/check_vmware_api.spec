Summary: An op5 Monitor plugin to monitor VMware virtualization environment
Name: monitor-plugin-check_vmware_api
Version: %{op5version}
Release: %{op5release}%{?dist}
License: GPL
Group: op5/system-addons
URL: http://www.op5.com/support
Source0: %name-%version.tar.gz
Prefix: /opt/plugins
BuildRoot: %{_tmppath}/%{name}-%{version}
BuildArch: noarch
Requires: perl
Requires: perl(Nagios::Plugin)
Requires: perl(File::Basename)
Requires: perl(HTTP::Date)

BuildRequires: perl
BuildRequires: perl-libwww-perl
BuildRequires: perl(Test::More)
BuildRequires: perl(Test::MockObject)
BuildRequires: perl(Nagios::Plugin)
BuildRequires: perl(XML::LibXML)
BuildRequires: perl(Crypt::SSLeay)
%if 0%{?suse_version}
# SLES-specific stuff
#BuildRequires: perl(UNIVERSAL::isa)
#BuildRequires: perl(UNIVERSAL::can)
%else
# Common RHEL stuff
%if 0%{?rhel} >= 6
# RHEL6-specific stuff
%else
# RHEL5-specific stuff
%endif
%endif

%description
This plugin is used to monitor VMware virtualization environments.
You may monitor DCs, single esx hosts, virtual machines and so on.
To be able to use the plugin you need to install VMware vSphere SDK for Perl.

%prep
%setup -q

%build
%__make test

%install
mkdir -p %buildroot/opt/plugins
cp check_vmware_api.pl %buildroot/opt/plugins/check_vmware_api.pl

pushd %buildroot%prefix
	ln -s check_vmware_api.pl check_vmware_api
	ln -s check_vmware_api check_esx3
popd

%clean
rm -rf %buildroot

%files
%defattr(-,root,root,-)
%attr(755,root,root) /opt/plugins/check_vmware_api.pl
%attr(755,root,root) /opt/plugins/check_vmware_api
%attr(755,root,root) /opt/plugins/check_esx3

%changelog
* Tue May 30 2013 Martin Kamijo <mk@op5.com>
Inital commit of the plugins
