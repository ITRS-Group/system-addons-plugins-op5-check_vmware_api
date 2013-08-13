package CheckVMwareAPI;
our $server_version_response = '<?xml version="1.0" encoding="UTF-8" ?>
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


our $retrieve_service_content_response = '<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<soapenv:Body>
<RetrieveServiceContentResponse xmlns="urn:vim25"><returnval><rootFolder type="Folder">ha-folder-root</rootFolder><propertyCollector type="PropertyCollector">ha-property-collector</propertyCollector><viewManager type="ViewManager">ViewManager</viewManager><about><name>VMware ESXi</name><fullName>VMware ESXi 5.1.0 build-799733</fullName><vendor>VMware, Inc.</vendor><version>5.1.0</version><build>799733</build><localeVersion>INTL</localeVersion><localeBuild>000</localeBuild><osType>vmnix-x86</osType><productLineId>embeddedEsx</productLineId><apiType>HostAgent</apiType><apiVersion>5.1</apiVersion><licenseProductName>VMware ESX Server</licenseProductName><licenseProductVersion>5.0</licenseProductVersion></about><setting type="OptionManager">HostAgentSettings</setting><userDirectory type="UserDirectory">ha-user-directory</userDirectory><sessionManager type="SessionManager">ha-sessionmgr</sessionManager><authorizationManager type="AuthorizationManager">ha-authmgr</authorizationManager><serviceManager type="ServiceManager">ha-servicemanager</serviceManager><perfManager type="PerformanceManager">ha-perfmgr</perfManager><eventManager type="EventManager">ha-eventmgr</eventManager><taskManager type="TaskManager">ha-taskmgr</taskManager><accountManager type="HostLocalAccountManager">ha-localacctmgr</accountManager><diagnosticManager type="DiagnosticManager">ha-diagnosticmgr</diagnosticManager><licenseManager type="LicenseManager">ha-license-manager</licenseManager><searchIndex type="SearchIndex">ha-searchindex</searchIndex><fileManager type="FileManager">ha-nfc-file-manager</fileManager><virtualDiskManager type="VirtualDiskManager">ha-vdiskmanager</virtualDiskManager><ovfManager type="OvfManager">ha-ovf-manager</ovfManager><dvSwitchManager type="DistributedVirtualSwitchManager">ha-dvsmanager</dvSwitchManager><localizationManager type="LocalizationManager">ha-l10n-manager</localizationManager><storageResourceManager type="StorageResourceManager">ha-storage-resource-manager</storageResourceManager><guestOperationsManager type="GuestOperationsManager">ha-guest-operations-manager</guestOperationsManager></returnval></RetrieveServiceContentResponse>
</soapenv:Body>
</soapenv:Envelope>';

our $login_response = '<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<soapenv:Body>
<LoginResponse xmlns="urn:vim25"><returnval><key>9dd4f538-837b-3d9c-d740-00f58137e862</key><userName>root</userName><fullName>Administrator</fullName><loginTime>1970-05-05T21:19:51.578469Z</loginTime><lastActiveTime>1970-05-05T21:19:51.578469Z</lastActiveTime><locale>en</locale><messageLocale>en</messageLocale><extensionSession>false</extensionSession><ipAddress>192.168.1.179</ipAddress><userAgent>VI Perl</userAgent><callCount>0</callCount></returnval></LoginResponse>
</soapenv:Body>
</soapenv:Envelope>';

our $logout_response='<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/"
 xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<soapenv:Body>
<LogoutResponse xmlns="urn:vim25"></LogoutResponse>
</soapenv:Body>
</soapenv:Envelope>';


1;
