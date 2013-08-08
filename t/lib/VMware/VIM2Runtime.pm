#
# Copyright 2006 VMware, Inc.  All rights reserved.
#

use 5.006001;
use strict;
use warnings;

use VMware::VICommon;
require VMware::VIMRuntime;
use Carp qw(confess croak);

Vim::set_server_version("2");
VIMRuntime::initialize();


##################################################################################
package AuthorizationManager;
our @ISA = qw(ViewBase AuthorizationManagerOperations);

VIMRuntime::make_get_set('AuthorizationManager', 'privilegeList', 'roleList', 'description');

our @property_list = (
   ['privilegeList', 'AuthorizationPrivilege', 'true'],
   ['roleList', 'AuthorizationRole', 'true'],
   ['description', 'AuthorizationDescription', undef],
);
sub get_property_list {
   return @property_list;
}

1;
##################################################################################

##################################################################################
package ClusterComputeResource;
our @ISA = qw(ComputeResource ClusterComputeResourceOperations);

VIMRuntime::make_get_set('ClusterComputeResource', 'configuration', 'drsRecommendation', 'migrationHistory');

our @property_list = (
   ['configuration', 'ClusterConfigInfo', undef],
   ['drsRecommendation', 'ClusterDrsRecommendation', 'true'],
   ['migrationHistory', 'ClusterDrsMigration', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package ComputeResource;
our @ISA = qw(ManagedEntity ComputeResourceOperations);

VIMRuntime::make_get_set('ComputeResource', 'resourcePool', 'host', 'datastore', 'network', 'summary', 'environmentBrowser');

our @property_list = (
   ['resourcePool', 'ResourcePool', undef],
   ['host', 'HostSystem', 'true'],
   ['datastore', 'Datastore', 'true'],
   ['network', 'Network', 'true'],
   ['summary', 'ComputeResourceSummary', undef],
   ['environmentBrowser', 'EnvironmentBrowser', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package CustomFieldsManager;
our @ISA = qw(ViewBase CustomFieldsManagerOperations);

VIMRuntime::make_get_set('CustomFieldsManager', 'field');

our @property_list = (
   ['field', 'CustomFieldDef', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package CustomizationSpecManager;
our @ISA = qw(ViewBase CustomizationSpecManagerOperations);

VIMRuntime::make_get_set('CustomizationSpecManager', 'info', 'encryptionKey');

our @property_list = (
   ['info', 'CustomizationSpecInfo', 'true'],
   ['encryptionKey', undef, 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package Datacenter;
our @ISA = qw(ManagedEntity DatacenterOperations);

VIMRuntime::make_get_set('Datacenter', 'vmFolder', 'hostFolder', 'datastore', 'network');

our @property_list = (
   ['vmFolder', 'Folder', undef],
   ['hostFolder', 'Folder', undef],
   ['datastore', 'Datastore', 'true'],
   ['network', 'Network', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package Datastore;
our @ISA = qw(ViewBase DatastoreOperations);

VIMRuntime::make_get_set('Datastore', 'info', 'summary', 'host', 'vm', 'browser', 'capability');

our @property_list = (
   ['info', 'DatastoreInfo', undef],
   ['summary', 'DatastoreSummary', undef],
   ['host', 'DatastoreHostMount', 'true'],
   ['vm', 'VirtualMachine', 'true'],
   ['browser', 'HostDatastoreBrowser', undef],
   ['capability', 'DatastoreCapability', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package DiagnosticManager;
our @ISA = qw(ViewBase DiagnosticManagerOperations);

VIMRuntime::make_get_set('DiagnosticManager');

our @property_list = (
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package EnvironmentBrowser;
our @ISA = qw(ViewBase EnvironmentBrowserOperations);

VIMRuntime::make_get_set('EnvironmentBrowser', 'datastoreBrowser');

our @property_list = (
   ['datastoreBrowser', 'HostDatastoreBrowser', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package Folder;
our @ISA = qw(ManagedEntity FolderOperations);

VIMRuntime::make_get_set('Folder', 'childType', 'childEntity');

our @property_list = (
   ['childType', undef, 'true'],
   ['childEntity', 'ManagedEntity', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HistoryCollector;
our @ISA = qw(ViewBase HistoryCollectorOperations);

VIMRuntime::make_get_set('HistoryCollector', 'filter');

our @property_list = (
   ['filter', undef, undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostSystem;
our @ISA = qw(ManagedEntity HostSystemOperations);

VIMRuntime::make_get_set('HostSystem', 'runtime', 'summary', 'hardware', 'capability', 'configManager', 'config', 'vm', 'datastore', 'network', 'datastoreBrowser', 'systemResources');

our @property_list = (
   ['runtime', 'HostRuntimeInfo', undef],
   ['summary', 'HostListSummary', undef],
   ['hardware', 'HostHardwareInfo', undef],
   ['capability', 'HostCapability', undef],
   ['configManager', 'HostConfigManager', undef],
   ['config', 'HostConfigInfo', undef],
   ['vm', 'VirtualMachine', 'true'],
   ['datastore', 'Datastore', 'true'],
   ['network', 'Network', 'true'],
   ['datastoreBrowser', 'HostDatastoreBrowser', undef],
   ['systemResources', 'HostSystemResourceInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package LicenseManager;
our @ISA = qw(ViewBase LicenseManagerOperations);

VIMRuntime::make_get_set('LicenseManager', 'source', 'sourceAvailable', 'featureInfo');

our @property_list = (
   ['source', 'LicenseSource', undef],
   ['sourceAvailable', undef, undef],
   ['featureInfo', 'LicenseFeatureInfo', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package ManagedEntity;
our @ISA = qw(EntityViewBase);

VIMRuntime::make_get_set('ManagedEntity', 'parent', 'customValue', 'overallStatus', 'configStatus', 'configIssue', 'effectiveRole', 'permission', 'name', 'disabledMethod', 'recentTask', 'declaredAlarmState', 'triggeredAlarmState');

our @property_list = (
   ['parent', 'ManagedEntity', undef],
   ['customValue', 'CustomFieldValue', 'true'],
   ['overallStatus', undef, undef],
   ['configStatus', undef, undef],
   ['configIssue', 'Event', 'true'],
   ['effectiveRole', undef, 'true'],
   ['permission', 'Permission', 'true'],
   ['name', undef, undef],
   ['disabledMethod', undef, 'true'],
   ['recentTask', 'Task', 'true'],
   ['declaredAlarmState', 'AlarmState', 'true'],
   ['triggeredAlarmState', 'AlarmState', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package Network;
our @ISA = qw(ViewBase NetworkOperations);

VIMRuntime::make_get_set('Network', 'name', 'summary', 'host', 'vm');

our @property_list = (
   ['name', undef, undef],
   ['summary', 'NetworkSummary', undef],
   ['host', 'HostSystem', 'true'],
   ['vm', 'VirtualMachine', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package PerformanceManager;
our @ISA = qw(ViewBase PerformanceManagerOperations);

VIMRuntime::make_get_set('PerformanceManager', 'description', 'historicalInterval', 'perfCounter');

our @property_list = (
   ['description', 'PerformanceDescription', undef],
   ['historicalInterval', 'PerfInterval', 'true'],
   ['perfCounter', 'PerfCounterInfo', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package ResourcePool;
our @ISA = qw(ManagedEntity ResourcePoolOperations);

VIMRuntime::make_get_set('ResourcePool', 'summary', 'runtime', 'owner', 'resourcePool', 'vm', 'config', 'childConfiguration');

our @property_list = (
   ['summary', 'ResourcePoolSummary', undef],
   ['runtime', 'ResourcePoolRuntimeInfo', undef],
   ['owner', 'ComputeResource', undef],
   ['resourcePool', 'ResourcePool', 'true'],
   ['vm', 'VirtualMachine', 'true'],
   ['config', 'ResourceConfigSpec', undef],
   ['childConfiguration', 'ResourceConfigSpec', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package SearchIndex;
our @ISA = qw(ViewBase SearchIndexOperations);

VIMRuntime::make_get_set('SearchIndex');

our @property_list = (
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package ServiceInstance;
our @ISA = qw(ViewBase ServiceInstanceOperations);

VIMRuntime::make_get_set('ServiceInstance', 'serverClock', 'capability', 'content');

our @property_list = (
   ['serverClock', undef, undef],
   ['capability', 'Capability', undef],
   ['content', 'ServiceContent', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package SessionManager;
our @ISA = qw(ViewBase SessionManagerOperations);

VIMRuntime::make_get_set('SessionManager', 'sessionList', 'currentSession', 'message', 'messageLocaleList', 'supportedLocaleList', 'defaultLocale');

our @property_list = (
   ['sessionList', 'UserSession', 'true'],
   ['currentSession', 'UserSession', undef],
   ['message', undef, undef],
   ['messageLocaleList', undef, 'true'],
   ['supportedLocaleList', undef, 'true'],
   ['defaultLocale', undef, undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package Task;
our @ISA = qw(ViewBase TaskOperations);

VIMRuntime::make_get_set('Task', 'info');

our @property_list = (
   ['info', 'TaskInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package TaskHistoryCollector;
our @ISA = qw(HistoryCollector TaskHistoryCollectorOperations);

VIMRuntime::make_get_set('TaskHistoryCollector', 'latestPage');

our @property_list = (
   ['latestPage', 'TaskInfo', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package TaskManager;
our @ISA = qw(ViewBase TaskManagerOperations);

VIMRuntime::make_get_set('TaskManager', 'recentTask', 'description', 'maxCollector');

our @property_list = (
   ['recentTask', 'Task', 'true'],
   ['description', 'TaskDescription', undef],
   ['maxCollector', undef, undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package UserDirectory;
our @ISA = qw(ViewBase UserDirectoryOperations);

VIMRuntime::make_get_set('UserDirectory', 'domainList');

our @property_list = (
   ['domainList', undef, 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package VirtualMachine;
our @ISA = qw(ManagedEntity VirtualMachineOperations);

VIMRuntime::make_get_set('VirtualMachine', 'capability', 'config', 'layout', 'environmentBrowser', 'resourcePool', 'resourceConfig', 'runtime', 'guest', 'summary', 'datastore', 'network', 'snapshot', 'guestHeartbeatStatus');

our @property_list = (
   ['capability', 'VirtualMachineCapability', undef],
   ['config', 'VirtualMachineConfigInfo', undef],
   ['layout', 'VirtualMachineFileLayout', undef],
   ['environmentBrowser', 'EnvironmentBrowser', undef],
   ['resourcePool', 'ResourcePool', undef],
   ['resourceConfig', 'ResourceConfigSpec', undef],
   ['runtime', 'VirtualMachineRuntimeInfo', undef],
   ['guest', 'GuestInfo', undef],
   ['summary', 'VirtualMachineSummary', undef],
   ['datastore', 'Datastore', 'true'],
   ['network', 'Network', 'true'],
   ['snapshot', 'VirtualMachineSnapshotInfo', undef],
   ['guestHeartbeatStatus', undef, undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package Alarm;
our @ISA = qw(ViewBase AlarmOperations);

VIMRuntime::make_get_set('Alarm', 'info');

our @property_list = (
   ['info', 'AlarmInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package AlarmManager;
our @ISA = qw(ViewBase AlarmManagerOperations);

VIMRuntime::make_get_set('AlarmManager', 'defaultExpression', 'description');

our @property_list = (
   ['defaultExpression', 'AlarmExpression', 'true'],
   ['description', 'AlarmDescription', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package EventHistoryCollector;
our @ISA = qw(HistoryCollector EventHistoryCollectorOperations);

VIMRuntime::make_get_set('EventHistoryCollector', 'latestPage');

our @property_list = (
   ['latestPage', 'Event', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package EventManager;
our @ISA = qw(ViewBase EventManagerOperations);

VIMRuntime::make_get_set('EventManager', 'description', 'latestEvent', 'maxCollector');

our @property_list = (
   ['description', 'EventDescription', undef],
   ['latestEvent', 'Event', undef],
   ['maxCollector', undef, undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostAutoStartManager;
our @ISA = qw(ViewBase HostAutoStartManagerOperations);

VIMRuntime::make_get_set('HostAutoStartManager', 'config');

our @property_list = (
   ['config', 'HostAutoStartManagerConfig', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostCpuSchedulerSystem;
our @ISA = qw(ViewBase HostCpuSchedulerSystemOperations);

VIMRuntime::make_get_set('HostCpuSchedulerSystem', 'hyperthreadInfo');

our @property_list = (
   ['hyperthreadInfo', 'HostHyperThreadScheduleInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostDatastoreBrowser;
our @ISA = qw(ViewBase HostDatastoreBrowserOperations);

VIMRuntime::make_get_set('HostDatastoreBrowser', 'datastore', 'supportedType');

our @property_list = (
   ['datastore', 'Datastore', 'true'],
   ['supportedType', 'FileQuery', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostDatastoreSystem;
our @ISA = qw(ViewBase HostDatastoreSystemOperations);

VIMRuntime::make_get_set('HostDatastoreSystem', 'datastore');

our @property_list = (
   ['datastore', 'Datastore', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostDiagnosticSystem;
our @ISA = qw(ViewBase HostDiagnosticSystemOperations);

VIMRuntime::make_get_set('HostDiagnosticSystem', 'activePartition');

our @property_list = (
   ['activePartition', 'HostDiagnosticPartition', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostDiskManagerLease;
our @ISA = qw(ViewBase HostDiskManagerLeaseOperations);

VIMRuntime::make_get_set('HostDiskManagerLease');

our @property_list = (
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostFirewallSystem;
our @ISA = qw(ViewBase HostFirewallSystemOperations);

VIMRuntime::make_get_set('HostFirewallSystem', 'firewallInfo');

our @property_list = (
   ['firewallInfo', 'HostFirewallInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostLocalAccountManager;
our @ISA = qw(ViewBase HostLocalAccountManagerOperations);

VIMRuntime::make_get_set('HostLocalAccountManager');

our @property_list = (
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostMemorySystem;
our @ISA = qw(ViewBase HostMemorySystemOperations);

VIMRuntime::make_get_set('HostMemorySystem', 'consoleReservationInfo');

our @property_list = (
   ['consoleReservationInfo', 'ServiceConsoleReservationInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostNetworkSystem;
our @ISA = qw(ViewBase HostNetworkSystemOperations);

VIMRuntime::make_get_set('HostNetworkSystem', 'capabilities', 'networkInfo', 'offloadCapabilities', 'networkConfig', 'dnsConfig', 'ipRouteConfig', 'consoleIpRouteConfig');

our @property_list = (
   ['capabilities', 'HostNetCapabilities', undef],
   ['networkInfo', 'HostNetworkInfo', undef],
   ['offloadCapabilities', 'HostNetOffloadCapabilities', undef],
   ['networkConfig', 'HostNetworkConfig', undef],
   ['dnsConfig', 'HostDnsConfig', undef],
   ['ipRouteConfig', 'HostIpRouteConfig', undef],
   ['consoleIpRouteConfig', 'HostIpRouteConfig', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostServiceSystem;
our @ISA = qw(ViewBase HostServiceSystemOperations);

VIMRuntime::make_get_set('HostServiceSystem', 'serviceInfo');

our @property_list = (
   ['serviceInfo', 'HostServiceInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostSnmpSystem;
our @ISA = qw(ViewBase HostSnmpSystemOperations);

VIMRuntime::make_get_set('HostSnmpSystem', 'snmpConfig');

our @property_list = (
   ['snmpConfig', 'HostSnmpConfig', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostStorageSystem;
our @ISA = qw(ViewBase HostStorageSystemOperations);

VIMRuntime::make_get_set('HostStorageSystem', 'storageDeviceInfo', 'fileSystemVolumeInfo');

our @property_list = (
   ['storageDeviceInfo', 'HostStorageDeviceInfo', undef],
   ['fileSystemVolumeInfo', 'HostFileSystemVolumeInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package HostVMotionSystem;
our @ISA = qw(ViewBase HostVMotionSystemOperations);

VIMRuntime::make_get_set('HostVMotionSystem', 'netConfig', 'ipConfig');

our @property_list = (
   ['netConfig', 'HostVMotionNetConfig', undef],
   ['ipConfig', 'HostIpConfig', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package OptionManager;
our @ISA = qw(ViewBase OptionManagerOperations);

VIMRuntime::make_get_set('OptionManager', 'supportedOption', 'setting');

our @property_list = (
   ['supportedOption', 'OptionDef', 'true'],
   ['setting', 'OptionValue', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package ScheduledTask;
our @ISA = qw(ViewBase ScheduledTaskOperations);

VIMRuntime::make_get_set('ScheduledTask', 'info');

our @property_list = (
   ['info', 'ScheduledTaskInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package ScheduledTaskManager;
our @ISA = qw(ViewBase ScheduledTaskManagerOperations);

VIMRuntime::make_get_set('ScheduledTaskManager', 'scheduledTask', 'description');

our @property_list = (
   ['scheduledTask', 'ScheduledTask', 'true'],
   ['description', 'ScheduledTaskDescription', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package VirtualMachineSnapshot;
our @ISA = qw(ViewBase VirtualMachineSnapshotOperations);

VIMRuntime::make_get_set('VirtualMachineSnapshot', 'config');

our @property_list = (
   ['config', 'VirtualMachineConfigInfo', undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package PropertyCollector;
our @ISA = qw(ViewBase PropertyCollectorOperations);

VIMRuntime::make_get_set('PropertyCollector', 'filter');

our @property_list = (
   ['filter', 'PropertyFilter', 'true'],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package PropertyFilter;
our @ISA = qw(ViewBase PropertyFilterOperations);

VIMRuntime::make_get_set('PropertyFilter', 'spec', 'partialUpdates');

our @property_list = (
   ['spec', 'PropertyFilterSpec', undef],
   ['partialUpdates', undef, undef],
);
sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);
}

1;
##################################################################################

##################################################################################
package AuthorizationManagerOperations;
sub AddAuthorizationRole {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddAuthorizationRole', %args));
   return $response
}

sub RemoveAuthorizationRole {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveAuthorizationRole', %args));
   return $response
}

sub UpdateAuthorizationRole {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateAuthorizationRole', %args));
   return $response
}

sub MergePermissions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MergePermissions', %args));
   return $response
}

sub RetrieveRolePermissions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveRolePermissions', %args));
   return $response
}

sub RetrieveEntityPermissions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveEntityPermissions', %args));
   return $response
}

sub RetrieveAllPermissions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveAllPermissions', %args));
   return $response
}

sub SetEntityPermissions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetEntityPermissions', %args));
   return $response
}

sub ResetEntityPermissions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ResetEntityPermissions', %args));
   return $response
}

sub RemoveEntityPermission {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveEntityPermission', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package ClusterComputeResourceOperations;
our @ISA = qw(ComputeResourceOperations);
sub ReconfigureCluster_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigureCluster_Task', %args));
   return $response
}

sub ReconfigureCluster {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ReconfigureCluster_Task(%args));
}

sub ApplyRecommendation {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ApplyRecommendation', %args));
   return $response
}

sub RecommendHostsForVm {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RecommendHostsForVm', %args));
   return $response
}

sub AddHost_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddHost_Task', %args));
   return $response
}

sub AddHost {
   my ($self, %args) = @_;
   return $self->waitForTask($self->AddHost_Task(%args));
}

sub MoveInto_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MoveInto_Task', %args));
   return $response
}

sub MoveInto {
   my ($self, %args) = @_;
   return $self->waitForTask($self->MoveInto_Task(%args));
}

sub MoveHostInto_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MoveHostInto_Task', %args));
   return $response
}

sub MoveHostInto {
   my ($self, %args) = @_;
   return $self->waitForTask($self->MoveHostInto_Task(%args));
}


1;
##################################################################################

##################################################################################
package ComputeResourceOperations;
our @ISA = qw(ManagedEntityOperations);

1;
##################################################################################

##################################################################################
package CustomFieldsManagerOperations;
sub AddCustomFieldDef {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddCustomFieldDef', %args));
   return $response
}

sub RemoveCustomFieldDef {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveCustomFieldDef', %args));
   return $response
}

sub RenameCustomFieldDef {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RenameCustomFieldDef', %args));
   return $response
}

sub SetField {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetField', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package CustomizationSpecManagerOperations;
sub DoesCustomizationSpecExist {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DoesCustomizationSpecExist', %args));
   return $response
}

sub GetCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('GetCustomizationSpec', %args));
   return $response
}

sub CreateCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateCustomizationSpec', %args));
   return $response
}

sub OverwriteCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('OverwriteCustomizationSpec', %args));
   return $response
}

sub DeleteCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DeleteCustomizationSpec', %args));
   return $response
}

sub DuplicateCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DuplicateCustomizationSpec', %args));
   return $response
}

sub RenameCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RenameCustomizationSpec', %args));
   return $response
}

sub CustomizationSpecItemToXml {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CustomizationSpecItemToXml', %args));
   return $response
}

sub XmlToCustomizationSpecItem {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('XmlToCustomizationSpecItem', %args));
   return $response
}

sub CheckCustomizationResources {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CheckCustomizationResources', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package DatacenterOperations;
our @ISA = qw(ManagedEntityOperations);
sub QueryConnectionInfo {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryConnectionInfo', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package DatastoreOperations;
sub RenameDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RenameDatastore', %args));
   return $response
}

sub RefreshDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RefreshDatastore', %args));
   return $response
}

sub DestroyDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DestroyDatastore', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package DiagnosticManagerOperations;
sub QueryDescriptions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryDescriptions', %args));
   return $response
}

sub BrowseDiagnosticLog {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('BrowseDiagnosticLog', %args));
   return $response
}

sub GenerateLogBundles_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('GenerateLogBundles_Task', %args));
   return $response
}

sub GenerateLogBundles {
   my ($self, %args) = @_;
   return $self->waitForTask($self->GenerateLogBundles_Task(%args));
}


1;
##################################################################################

##################################################################################
package EnvironmentBrowserOperations;
sub QueryConfigOptionDescriptor {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryConfigOptionDescriptor', %args));
   return $response
}

sub QueryConfigOption {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryConfigOption', %args));
   return $response
}

sub QueryConfigTarget {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryConfigTarget', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package FolderOperations;
our @ISA = qw(ManagedEntityOperations);
sub CreateFolder {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateFolder', %args));
   return $response
}

sub MoveIntoFolder_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MoveIntoFolder_Task', %args));
   return $response
}

sub MoveIntoFolder {
   my ($self, %args) = @_;
   return $self->waitForTask($self->MoveIntoFolder_Task(%args));
}

sub CreateVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateVM_Task', %args));
   return $response
}

sub CreateVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->CreateVM_Task(%args));
}

sub RegisterVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RegisterVM_Task', %args));
   return $response
}

sub RegisterVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RegisterVM_Task(%args));
}

sub CreateCluster {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateCluster', %args));
   return $response
}

sub AddStandaloneHost_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddStandaloneHost_Task', %args));
   return $response
}

sub AddStandaloneHost {
   my ($self, %args) = @_;
   return $self->waitForTask($self->AddStandaloneHost_Task(%args));
}

sub CreateDatacenter {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateDatacenter', %args));
   return $response
}

sub UnregisterAndDestroy_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UnregisterAndDestroy_Task', %args));
   return $response
}

sub UnregisterAndDestroy {
   my ($self, %args) = @_;
   return $self->waitForTask($self->UnregisterAndDestroy_Task(%args));
}


1;
##################################################################################

##################################################################################
package HistoryCollectorOperations;
sub SetCollectorPageSize {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetCollectorPageSize', %args));
   return $response
}

sub RewindCollector {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RewindCollector', %args));
   return $response
}

sub ResetCollector {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ResetCollector', %args));
   return $response
}

sub DestroyCollector {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DestroyCollector', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostSystemOperations;
our @ISA = qw(ManagedEntityOperations);
sub QueryHostConnectionInfo {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryHostConnectionInfo', %args));
   return $response
}

sub UpdateSystemResources {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateSystemResources', %args));
   return $response
}

sub ReconnectHost_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconnectHost_Task', %args));
   return $response
}

sub ReconnectHost {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ReconnectHost_Task(%args));
}

sub DisconnectHost_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DisconnectHost_Task', %args));
   return $response
}

sub DisconnectHost {
   my ($self, %args) = @_;
   return $self->waitForTask($self->DisconnectHost_Task(%args));
}

sub EnterMaintenanceMode_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('EnterMaintenanceMode_Task', %args));
   return $response
}

sub EnterMaintenanceMode {
   my ($self, %args) = @_;
   return $self->waitForTask($self->EnterMaintenanceMode_Task(%args));
}

sub ExitMaintenanceMode_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ExitMaintenanceMode_Task', %args));
   return $response
}

sub ExitMaintenanceMode {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ExitMaintenanceMode_Task(%args));
}

sub RebootHost_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RebootHost_Task', %args));
   return $response
}

sub RebootHost {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RebootHost_Task(%args));
}

sub ShutdownHost_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ShutdownHost_Task', %args));
   return $response
}

sub ShutdownHost {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ShutdownHost_Task(%args));
}

sub QueryMemoryOverhead {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryMemoryOverhead', %args));
   return $response
}

sub ReconfigureHostForDAS_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigureHostForDAS_Task', %args));
   return $response
}

sub ReconfigureHostForDAS {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ReconfigureHostForDAS_Task(%args));
}


1;
##################################################################################

##################################################################################
package LicenseManagerOperations;
sub QueryLicenseSourceAvailability {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryLicenseSourceAvailability', %args));
   return $response
}

sub QueryLicenseUsage {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryLicenseUsage', %args));
   return $response
}

sub SetLicenseEdition {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetLicenseEdition', %args));
   return $response
}

sub CheckLicenseFeature {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CheckLicenseFeature', %args));
   return $response
}

sub EnableFeature {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('EnableFeature', %args));
   return $response
}

sub DisableFeature {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DisableFeature', %args));
   return $response
}

sub ConfigureLicenseSource {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ConfigureLicenseSource', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package ManagedEntityOperations;
sub Reload {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('Reload', %args));
   return $response
}

sub Rename_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('Rename_Task', %args));
   return $response
}

sub Rename {
   my ($self, %args) = @_;
   return $self->waitForTask($self->Rename_Task(%args));
}

sub Destroy_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('Destroy_Task', %args));
   return $response
}

sub Destroy {
   my ($self, %args) = @_;
   return $self->waitForTask($self->Destroy_Task(%args));
}


1;
##################################################################################

##################################################################################
package NetworkOperations;
sub DestroyNetwork {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DestroyNetwork', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package PerformanceManagerOperations;
sub QueryPerfProviderSummary {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryPerfProviderSummary', %args));
   return $response
}

sub QueryAvailablePerfMetric {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryAvailablePerfMetric', %args));
   return $response
}

sub QueryPerfCounter {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryPerfCounter', %args));
   return $response
}

sub QueryPerf {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryPerf', %args));
   return $response
}

sub QueryPerfComposite {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryPerfComposite', %args));
   return $response
}

sub CreatePerfInterval {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreatePerfInterval', %args));
   return $response
}

sub RemovePerfInterval {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemovePerfInterval', %args));
   return $response
}

sub UpdatePerfInterval {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdatePerfInterval', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package ResourcePoolOperations;
our @ISA = qw(ManagedEntityOperations);
sub UpdateConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateConfig', %args));
   return $response
}

sub MoveIntoResourcePool {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MoveIntoResourcePool', %args));
   return $response
}

sub UpdateChildResourceConfiguration {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateChildResourceConfiguration', %args));
   return $response
}

sub CreateResourcePool {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateResourcePool', %args));
   return $response
}

sub DestroyChildren {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DestroyChildren', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package SearchIndexOperations;
sub FindByUuid {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FindByUuid', %args));
   return $response
}

sub FindByDatastorePath {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FindByDatastorePath', %args));
   return $response
}

sub FindByDnsName {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FindByDnsName', %args));
   return $response
}

sub FindByIp {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FindByIp', %args));
   return $response
}

sub FindByInventoryPath {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FindByInventoryPath', %args));
   return $response
}

sub FindChild {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FindChild', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package ServiceInstanceOperations;
sub CurrentTime {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CurrentTime', %args));
   return $response
}

sub RetrieveServiceContent {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveServiceContent', %args));
   return $response
}

sub ValidateMigration {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ValidateMigration', %args));
   return $response
}

sub QueryVMotionCompatibility {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryVMotionCompatibility', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package SessionManagerOperations;
sub UpdateServiceMessage {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateServiceMessage', %args));
   return $response
}

sub Login {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('Login', %args));
   return $response
}

sub Logout {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('Logout', %args));
   return $response
}

sub AcquireLocalTicket {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AcquireLocalTicket', %args));
   return $response
}

sub TerminateSession {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('TerminateSession', %args));
   return $response
}

sub SetLocale {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetLocale', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package TaskOperations;
sub CancelTask {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CancelTask', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package TaskHistoryCollectorOperations;
our @ISA = qw(HistoryCollectorOperations);
sub ReadNextTasks {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReadNextTasks', %args));
   return $response
}

sub ReadPreviousTasks {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReadPreviousTasks', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package TaskManagerOperations;
sub CreateCollectorForTasks {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateCollectorForTasks', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package UserDirectoryOperations;
sub RetrieveUserGroups {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveUserGroups', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package VirtualMachineOperations;
our @ISA = qw(ManagedEntityOperations);
sub CreateSnapshot_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateSnapshot_Task', %args));
   return $response
}

sub CreateSnapshot {
   my ($self, %args) = @_;
   return $self->waitForTask($self->CreateSnapshot_Task(%args));
}

sub RevertToCurrentSnapshot_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RevertToCurrentSnapshot_Task', %args));
   return $response
}

sub RevertToCurrentSnapshot {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RevertToCurrentSnapshot_Task(%args));
}

sub RemoveAllSnapshots_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveAllSnapshots_Task', %args));
   return $response
}

sub RemoveAllSnapshots {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RemoveAllSnapshots_Task(%args));
}

sub ReconfigVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigVM_Task', %args));
   return $response
}

sub ReconfigVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ReconfigVM_Task(%args));
}

sub UpgradeVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpgradeVM_Task', %args));
   return $response
}

sub UpgradeVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->UpgradeVM_Task(%args));
}

sub PowerOnVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('PowerOnVM_Task', %args));
   return $response
}

sub PowerOnVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->PowerOnVM_Task(%args));
}

sub PowerOffVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('PowerOffVM_Task', %args));
   return $response
}

sub PowerOffVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->PowerOffVM_Task(%args));
}

sub SuspendVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SuspendVM_Task', %args));
   return $response
}

sub SuspendVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->SuspendVM_Task(%args));
}

sub ResetVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ResetVM_Task', %args));
   return $response
}

sub ResetVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->ResetVM_Task(%args));
}

sub ShutdownGuest {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ShutdownGuest', %args));
   return $response
}

sub RebootGuest {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RebootGuest', %args));
   return $response
}

sub StandbyGuest {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('StandbyGuest', %args));
   return $response
}

sub AnswerVM {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AnswerVM', %args));
   return $response
}

sub CustomizeVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CustomizeVM_Task', %args));
   return $response
}

sub CustomizeVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->CustomizeVM_Task(%args));
}

sub CheckCustomizationSpec {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CheckCustomizationSpec', %args));
   return $response
}

sub MigrateVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MigrateVM_Task', %args));
   return $response
}

sub MigrateVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->MigrateVM_Task(%args));
}

sub RelocateVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RelocateVM_Task', %args));
   return $response
}

sub RelocateVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RelocateVM_Task(%args));
}

sub CloneVM_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CloneVM_Task', %args));
   return $response
}

sub CloneVM {
   my ($self, %args) = @_;
   return $self->waitForTask($self->CloneVM_Task(%args));
}

sub MarkAsTemplate {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MarkAsTemplate', %args));
   return $response
}

sub MarkAsVirtualMachine {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MarkAsVirtualMachine', %args));
   return $response
}

sub UnregisterVM {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UnregisterVM', %args));
   return $response
}

sub ResetGuestInformation {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ResetGuestInformation', %args));
   return $response
}

sub MountToolsInstaller {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('MountToolsInstaller', %args));
   return $response
}

sub UnmountToolsInstaller {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UnmountToolsInstaller', %args));
   return $response
}

sub UpgradeTools_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpgradeTools_Task', %args));
   return $response
}

sub UpgradeTools {
   my ($self, %args) = @_;
   return $self->waitForTask($self->UpgradeTools_Task(%args));
}

sub AcquireMksTicket {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AcquireMksTicket', %args));
   return $response
}

sub SetScreenResolution {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetScreenResolution', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package AlarmOperations;
sub RemoveAlarm {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveAlarm', %args));
   return $response
}

sub ReconfigureAlarm {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigureAlarm', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package AlarmManagerOperations;
sub CreateAlarm {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateAlarm', %args));
   return $response
}

sub GetAlarm {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('GetAlarm', %args));
   return $response
}

sub GetAlarmState {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('GetAlarmState', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package EventHistoryCollectorOperations;
our @ISA = qw(HistoryCollectorOperations);
sub ReadNextEvents {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReadNextEvents', %args));
   return $response
}

sub ReadPreviousEvents {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReadPreviousEvents', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package EventManagerOperations;
sub CreateCollectorForEvents {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateCollectorForEvents', %args));
   return $response
}

sub LogUserEvent {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('LogUserEvent', %args));
   return $response
}

sub QueryEvents {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryEvents', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostAutoStartManagerOperations;
sub ReconfigureAutostart {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigureAutostart', %args));
   return $response
}

sub AutoStartPowerOn {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AutoStartPowerOn', %args));
   return $response
}

sub AutoStartPowerOff {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AutoStartPowerOff', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostCpuSchedulerSystemOperations;
sub EnableHyperThreading {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('EnableHyperThreading', %args));
   return $response
}

sub DisableHyperThreading {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DisableHyperThreading', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostDatastoreBrowserOperations;
sub SearchDatastore_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SearchDatastore_Task', %args));
   return $response
}

sub SearchDatastore {
   my ($self, %args) = @_;
   return $self->waitForTask($self->SearchDatastore_Task(%args));
}

sub SearchDatastoreSubFolders_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SearchDatastoreSubFolders_Task', %args));
   return $response
}

sub SearchDatastoreSubFolders {
   my ($self, %args) = @_;
   return $self->waitForTask($self->SearchDatastoreSubFolders_Task(%args));
}

sub DeleteFile {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DeleteFile', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostDatastoreSystemOperations;
sub QueryAvailableDisksForVmfs {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryAvailableDisksForVmfs', %args));
   return $response
}

sub QueryVmfsDatastoreCreateOptions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryVmfsDatastoreCreateOptions', %args));
   return $response
}

sub CreateVmfsDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateVmfsDatastore', %args));
   return $response
}

sub QueryVmfsDatastoreExtendOptions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryVmfsDatastoreExtendOptions', %args));
   return $response
}

sub ExtendVmfsDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ExtendVmfsDatastore', %args));
   return $response
}

sub CreateNasDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateNasDatastore', %args));
   return $response
}

sub CreateLocalDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateLocalDatastore', %args));
   return $response
}

sub RemoveDatastore {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveDatastore', %args));
   return $response
}

sub ConfigureDatastorePrincipal {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ConfigureDatastorePrincipal', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostDiagnosticSystemOperations;
sub QueryAvailablePartition {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryAvailablePartition', %args));
   return $response
}

sub SelectActivePartition {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SelectActivePartition', %args));
   return $response
}

sub QueryPartitionCreateOptions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryPartitionCreateOptions', %args));
   return $response
}

sub QueryPartitionCreateDesc {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryPartitionCreateDesc', %args));
   return $response
}

sub CreateDiagnosticPartition {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateDiagnosticPartition', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostDiskManagerLeaseOperations;
sub RenewLease {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RenewLease', %args));
   return $response
}

sub ReleaseLease {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReleaseLease', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostFirewallSystemOperations;
sub UpdateDefaultPolicy {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateDefaultPolicy', %args));
   return $response
}

sub EnableRuleset {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('EnableRuleset', %args));
   return $response
}

sub DisableRuleset {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DisableRuleset', %args));
   return $response
}

sub RefreshFirewall {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RefreshFirewall', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostLocalAccountManagerOperations;
sub CreateUser {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateUser', %args));
   return $response
}

sub UpdateUser {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateUser', %args));
   return $response
}

sub CreateGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateGroup', %args));
   return $response
}

sub RemoveUser {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveUser', %args));
   return $response
}

sub RemoveGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveGroup', %args));
   return $response
}

sub AssignUserToGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AssignUserToGroup', %args));
   return $response
}

sub UnassignUserFromGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UnassignUserFromGroup', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostMemorySystemOperations;
sub ReconfigureServiceConsoleReservation {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigureServiceConsoleReservation', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostNetworkSystemOperations;
sub UpdateNetworkConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateNetworkConfig', %args));
   return $response
}

sub UpdateDnsConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateDnsConfig', %args));
   return $response
}

sub UpdateIpRouteConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateIpRouteConfig', %args));
   return $response
}

sub UpdateConsoleIpRouteConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateConsoleIpRouteConfig', %args));
   return $response
}

sub AddVirtualSwitch {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddVirtualSwitch', %args));
   return $response
}

sub RemoveVirtualSwitch {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveVirtualSwitch', %args));
   return $response
}

sub UpdateVirtualSwitch {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateVirtualSwitch', %args));
   return $response
}

sub AddPortGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddPortGroup', %args));
   return $response
}

sub RemovePortGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemovePortGroup', %args));
   return $response
}

sub UpdatePortGroup {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdatePortGroup', %args));
   return $response
}

sub UpdatePhysicalNicLinkSpeed {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdatePhysicalNicLinkSpeed', %args));
   return $response
}

sub QueryNetworkHint {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryNetworkHint', %args));
   return $response
}

sub AddVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddVirtualNic', %args));
   return $response
}

sub RemoveVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveVirtualNic', %args));
   return $response
}

sub UpdateVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateVirtualNic', %args));
   return $response
}

sub AddServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddServiceConsoleVirtualNic', %args));
   return $response
}

sub RemoveServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveServiceConsoleVirtualNic', %args));
   return $response
}

sub UpdateServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateServiceConsoleVirtualNic', %args));
   return $response
}

sub RestartServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RestartServiceConsoleVirtualNic', %args));
   return $response
}

sub RefreshNetworkSystem {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RefreshNetworkSystem', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostServiceSystemOperations;
sub UpdateServicePolicy {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateServicePolicy', %args));
   return $response
}

sub StartService {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('StartService', %args));
   return $response
}

sub StopService {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('StopService', %args));
   return $response
}

sub RestartService {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RestartService', %args));
   return $response
}

sub UninstallService {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UninstallService', %args));
   return $response
}

sub RefreshServices {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RefreshServices', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostSnmpSystemOperations;
sub CheckIfMasterSnmpAgentRunning {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CheckIfMasterSnmpAgentRunning', %args));
   return $response
}

sub UpdateSnmpConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateSnmpConfig', %args));
   return $response
}

sub RestartMasterSnmpAgent {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RestartMasterSnmpAgent', %args));
   return $response
}

sub StopMasterSnmpAgent {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('StopMasterSnmpAgent', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostStorageSystemOperations;
sub RetrieveDiskPartitionInfo {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveDiskPartitionInfo', %args));
   return $response
}

sub ComputeDiskPartitionInfo {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ComputeDiskPartitionInfo', %args));
   return $response
}

sub UpdateDiskPartitions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateDiskPartitions', %args));
   return $response
}

sub FormatVmfs {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('FormatVmfs', %args));
   return $response
}

sub RescanVmfs {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RescanVmfs', %args));
   return $response
}

sub AttachVmfsExtent {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AttachVmfsExtent', %args));
   return $response
}

sub UpgradeVmfs {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpgradeVmfs', %args));
   return $response
}

sub UpgradeVmLayout {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpgradeVmLayout', %args));
   return $response
}

sub RescanHba {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RescanHba', %args));
   return $response
}

sub RescanAllHba {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RescanAllHba', %args));
   return $response
}

sub UpdateSoftwareInternetScsiEnabled {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateSoftwareInternetScsiEnabled', %args));
   return $response
}

sub UpdateInternetScsiDiscoveryProperties {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateInternetScsiDiscoveryProperties', %args));
   return $response
}

sub UpdateInternetScsiAuthenticationProperties {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateInternetScsiAuthenticationProperties', %args));
   return $response
}

sub UpdateInternetScsiIPProperties {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateInternetScsiIPProperties', %args));
   return $response
}

sub UpdateInternetScsiName {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateInternetScsiName', %args));
   return $response
}

sub UpdateInternetScsiAlias {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateInternetScsiAlias', %args));
   return $response
}

sub AddInternetScsiSendTargets {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddInternetScsiSendTargets', %args));
   return $response
}

sub RemoveInternetScsiSendTargets {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveInternetScsiSendTargets', %args));
   return $response
}

sub AddInternetScsiStaticTargets {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('AddInternetScsiStaticTargets', %args));
   return $response
}

sub RemoveInternetScsiStaticTargets {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveInternetScsiStaticTargets', %args));
   return $response
}

sub EnableMultipathPath {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('EnableMultipathPath', %args));
   return $response
}

sub DisableMultipathPath {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DisableMultipathPath', %args));
   return $response
}

sub SetMultipathLunPolicy {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SetMultipathLunPolicy', %args));
   return $response
}

sub RefreshStorageSystem {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RefreshStorageSystem', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package HostVMotionSystemOperations;
sub UpdateIpConfig {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateIpConfig', %args));
   return $response
}

sub SelectVnic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('SelectVnic', %args));
   return $response
}

sub DeselectVnic {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DeselectVnic', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package OptionManagerOperations;
sub QueryOptions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('QueryOptions', %args));
   return $response
}

sub UpdateOptions {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('UpdateOptions', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package ScheduledTaskOperations;
sub RemoveScheduledTask {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveScheduledTask', %args));
   return $response
}

sub ReconfigureScheduledTask {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('ReconfigureScheduledTask', %args));
   return $response
}

sub RunScheduledTask {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RunScheduledTask', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package ScheduledTaskManagerOperations;
sub CreateScheduledTask {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateScheduledTask', %args));
   return $response
}

sub RetrieveEntityScheduledTask {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveEntityScheduledTask', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package VirtualMachineSnapshotOperations;
sub RevertToSnapshot_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RevertToSnapshot_Task', %args));
   return $response
}

sub RevertToSnapshot {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RevertToSnapshot_Task(%args));
}

sub RemoveSnapshot_Task {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RemoveSnapshot_Task', %args));
   return $response
}

sub RemoveSnapshot {
   my ($self, %args) = @_;
   return $self->waitForTask($self->RemoveSnapshot_Task(%args));
}

sub RenameSnapshot {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RenameSnapshot', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package PropertyCollectorOperations;
sub CreateFilter {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CreateFilter', %args));
   return $response
}

sub RetrieveProperties {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('RetrieveProperties', %args));
   return $response
}

sub CheckForUpdates {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CheckForUpdates', %args));
   return $response
}

sub WaitForUpdates {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('WaitForUpdates', %args));
   return $response
}

sub CancelWaitForUpdates {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('CancelWaitForUpdates', %args));
   return $response
}


1;
##################################################################################

##################################################################################
package PropertyFilterOperations;
sub DestroyPropertyFilter {
   my ($self, %args) = @_;
   my $response = Util::check_fault($self->invoke('DestroyPropertyFilter', %args));
   return $response
}


1;
##################################################################################

__END__
=head1 NAME

VMware::VIRuntime - VI Perl Toolkit runtime module

=head1 SYNOPSIS

   use strict;
   use VMware::VIRuntime;

   # login
   Vim::login(service_url => 'https://localhost/sdk/vimService',
              user_name => 'Administrator',
              password => 'mypassword');

   # get 'VirtualMachineView' for all VM's that are poweredOn and is running a Windows guest
   my $vm_views = Vim::find_entity_views(view_type => 'VirtualMachine',
                                         filter => { 'guest.guestFullName' => '.*Windows.*',
                                                     'runtime.powerState' => 'poweredOn' });

   # snapshot all running / powered on Windows vm's
   foreach (@$vm_views) {
      $_->CreateSnapshot(name => 'nightly backup',
                         description => 'Nightly backup of Windows machines',
                         memory => 0,
                         quiesce => 1);
   }

   # logout
   Vim::logout();
  
=head1 DESCRIPTION

VMware::VIRuntime module provides an interface to discover and interact with
managed objects as specified by VMware Infrastructure API.  The module provides
views that correspond to managed objec type definitions detailed in reference guide
(available for download with SDK package at http://www.vmware.com/download/sdk/).
Managed object views in this runtime module provides access to methods
and properties.

Object discovery is provided through Vim::find_entity_view subroutine
which allows for constraint based search/filtering of inventory objects
based on filter parameter.

This modules also provides synchronous version of methods that return
Task object (methods with '_Task' appended to their names). For example,
PowerOnVM_Task method for VirtualMachine view provides PowerOnVM operation
that blocks until task completion.  

The module is built(depends) on Perl binding for VI API (VMware::VIStub)

=head1 SEE ALSO

VI Perl Toolkit Guide is available at ./doc/guide.html in module package.

VI API Programming guide and reference guide is available for download at
<http://www.vmware.com/download/sdk/>


=head1 COPYRIGHT AND LICENSE

The Original Software is licensed under the CDDL v. 1.0 only and cannot 
be distributed or otherwise made available under any subsequent version 
of the license.  This License hall be governed by and construed in 
accordance with the laws of the State of California, excluding its 
conflict-of-law provisions.  Any litigation relating to this License 
will be brought solely in the federal court in the Northern District 
of California or the state court in the County of Santa Clara.  

A copy of the CDDL license is included in this distribution.


Copyright (c) 2006, VMware, Inc.  All rights not expressly granted herein 
are reserved. 

=cut

