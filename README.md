# Welcome to check VMware API
Check VMware API is a plugin developed by op5 to primarily be used with op5
Monitor, but can also be used in Naemon or Nagios installations, to monitor
VMware ESX and vSphere servers. You can monitor either a single ESX(i)/vSphere
server or a VMware VirtualCenter/vCenter Server and individual virtual
machines. If you have a VMware cluster you should monitor the data center
(VMware VirtualCenter/vCenter Server) and not the individual ESX/vSphere
servers.

Supports check status of ESX(i) server, vSphere 5 and vSphere 6.

## Supported features

The supported featureset will differ a bit between VMWare 5 and VMWare 6; please refer to the tables below for reference:

### Checks supported for Hosts
| Check   | Vmware 5 | Vmware 6                                                                                  |
|---------|----------|-------------------------------------------------------------------------------------------|
| CPU     | Yes      | Yes                                                                                       |
| IO      | Yes      | Yes                                                                                       |
| Memory  | Yes      | Yes                                                                                       |
| Network | Yes      | Yes                                                                                       |
| Runtime | Yes      | Partially: -Overview -Connection state -Health -Maintenance -Status -Storage Health       |
| Service | Yes      | Yes                                                                                       |
| Uptime  | No       | Yes                                                                                       |
| Storage | Yes      | No                                                                                        |

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

## Documentation
* Read the OP5 [Monitoring VMware ESX, ESXi, vSphere and vCenter Server](https://kb.op5.com/x/J4IK)  (for OP5 Monitor)
* Subscribe to the [op5-users](http://lists.op5.com/mailman/listinfo/op5-users) mailing list
* Browse the [mailing list archives](http://lists.op5.com/pipermail/op5-users/)

## Get involved - Contribute to the Check VMware API project
It is easy to get involved in the project and to contribute!
* Start using the plugin and if you like what you see, help by spreading the word on blogs and forums.
* Post your comments and feedback at the bottom of this page
Sign up at the [op5-users](http://lists.op5.com/mailman/listinfo/op5-users) mailing list to join the conversation and help other users by answering questions. It is here that you can follow the project and contribute your code and bugfixes. (The mailing list is not project specific)
* If you find a bug you can [report the bug here](https://bugs.op5.com/) or on the mailing list
* If you miss any documentation or know how to solve an undocumented problem you can contribute with documentation here in the op5 Knowledge Base.

## License
See LICENSE.
