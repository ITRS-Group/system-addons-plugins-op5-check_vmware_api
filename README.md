# Welcome to check VMware API
Check VMware API is a plugin developed by op5 to primarily be used with op5
Monitor, but can also be used in Naemon or Nagios installations, to monitor
VMware ESX and vSphere servers. You can monitor either a single ESX(i)/vSphere
server or a VMware VirtualCenter/vCenter Server and individual virtual
machines. If you have a VMware cluster you should monitor the data center
(VMware VirtualCenter/vCenter Server) and not the individual ESX/vSphere
servers.

Supports check status of VMware ESX 3.x, ESX(i) server, vSphere 4 and vSphere 5.

## Prerequisites
'VMware vSphere SDK for Perl', available at
https://my.vmware.com/group/vmware/downloads (requires a free account that you
sign up for at the same page).

## Installation
This is how to install the plugin on CentOS with VMware vSphere SDK for Perl
5.1.
- Download the latest version of the vSphere SDK for Perl package from VMware
  support page.
- In this example we use VMware-vSphere-Perl-SDK-5.1.0-780721.x86_64.tar.gz.
- Make sure the following packages are installed.
```bash
$ sudo yum install openssl-devel perl-Archive-Zip perl-Class-MethodMaker uuid-perl perl-SOAP-Lite perl-XML-SAX perl-XML-NamespaceSupport perl-XML-LibXML perl-MIME-Lite perl-MIME-Types perl-MailTools perl-TimeDate uuid libuuid perl-Data-Dump perl-UUID cpan libxml2-devel perl-libwww-perl perl-Test-MockObject perl-Test-Simple perl-Monitoring-Plugin perl-Class-Accessor perl-Config-Tiny
```
- Upload the file "VMware-vSphere-Perl-SDK*.tar.gz" to your op5 Monitor server’s
/root directory.
```bash
$ cd /root/
$ tar xvzf VMware-vSphere-Perl-SDK-5.1.0-780721.x86_64.tar.gz
$ cd vmware-vsphere-cli-distrib
$ export ftp_proxy=
$ export http_proxy=
$ ./vmware-install.pl

 "Creating a new vSphere CLI installer database using the tar4 format.

  Installing vSphere CLI 5.1.0 build-780721 for Linux.

   You must read and accept the vSphere CLI End User License Agreement to
   continue.
   Press enter to display it."
   "Do you accept? (yes/no)
```
- Type “yes” and press "enter".
- In which directory do you want to install the executable files?
```bash
[/usr/bin]
```
- Press Enter
```bash
Please wait while copying vSphere CLI files...

The installation of vSphere CLI 5.1.0 build-780721 for Linux completed
successfully. You can decide to remove this software from your system at any
time by invoking the following command:
"/usr/bin/vmware-uninstall-vSphere-CLI.pl".

This installer has successfully installed both vSphere CLI and the vSphere SDK
for Perl.  The following Perl modules were found on the system but may be too
old to work with vSphere CLI:
Compress::Zlib 2.037 or newer
Compress::Raw::Zlib 2.037 or newer
version 0.78 or newer
IO::Compress::Base 2.037 or newer
IO::Compress::Zlib::Constants 2.037 or newer
LWP::Protocol::https 5.805 or newer
Enjoy,
--the VMware team
root@op5-system:~/vmware-vsphere-cli-distrib#
```
- Note that the the issues with old Perl modules DOES NOT need to be resolved.
  This does not impact the plugins functionality.
- Now, clone or download this repository.
- Within the check_vmware_api repository, type `make` to run the test suit.
- Copy the check_vmware_api.pl to a suitable location and make sure it is
  exicutable. Will vary between installations.
```bash
$ cp check_vmware_api.pl /opt/plugins/check_vmware_api
$ cd /opt/plugins/
$ chmod 755 check_vmware_api
```

## Usage
Simply run the plugin with:
```bash
$ /opt/plugins/check_vmware_api --help
```

## License
See LICENSE.
