#
# Copyright 2006 VMware, Inc.  All rights reserved.
#

use 5.006001;
use strict;
use warnings;

use XML::LibXML;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Headers;
use HTTP::Response;
use HTTP::Cookies;
use Data::Dumper;



##################################################################################
package DynamicArray;
our @ISA = qw(ComplexType);

our @property_list = (
   ['dynamicType', undef, undef, 0],
   ['val', 'anyType', 1, 1],
);


VIMRuntime::make_get_set('DynamicArray', 'dynamicType', 'val');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DynamicData;
our @ISA = qw(ComplexType);

our @property_list = (
   ['dynamicType', undef, undef, 0],
   ['dynamicProperty', 'DynamicProperty', 1, 0],
);


VIMRuntime::make_get_set('DynamicData', 'dynamicType', 'dynamicProperty');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DynamicProperty;
our @ISA = qw(ComplexType);

our @property_list = (
   ['name', undef, undef, 1],
   ['val', 'anyType', undef, 1],
);


VIMRuntime::make_get_set('DynamicProperty', 'name', 'val');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfDynamicProperty;
our @ISA = qw(ComplexType);

our @property_list = (
   ['DynamicProperty', 'DynamicProperty', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfDynamicProperty', 'DynamicProperty');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCommunication;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('HostCommunication');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNotConnected;
our @ISA = qw(HostCommunication);

our @property_list = (
);


VIMRuntime::make_get_set('HostNotConnected');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNotReachable;
our @ISA = qw(HostCommunication);

our @property_list = (
);


VIMRuntime::make_get_set('HostNotReachable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidArgument;
our @ISA = qw(RuntimeFault);

our @property_list = (
   ['invalidProperty', undef, undef, 0],
);


VIMRuntime::make_get_set('InvalidArgument', 'invalidProperty');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidRequest;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidRequest');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidType;
our @ISA = qw(InvalidRequest);

our @property_list = (
   ['argument', undef, undef, 0],
);


VIMRuntime::make_get_set('InvalidType', 'argument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ManagedObjectNotFound;
our @ISA = qw(RuntimeFault);

our @property_list = (
   ['obj', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('ManagedObjectNotFound', 'obj');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MethodNotFound;
our @ISA = qw(InvalidRequest);

our @property_list = (
   ['receiver', 'ManagedObjectReference', undef, 1],
   ['method', undef, undef, 1],
);


VIMRuntime::make_get_set('MethodNotFound', 'receiver', 'method');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotEnoughLicenses;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('NotEnoughLicenses');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotImplemented;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('NotImplemented');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotSupported;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('NotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RequestCanceled;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('RequestCanceled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SecurityError;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('SecurityError');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SystemError;
our @ISA = qw(RuntimeFault);

our @property_list = (
   ['reason', undef, undef, 1],
);


VIMRuntime::make_get_set('SystemError', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidCollectorVersion;
our @ISA = qw(MethodFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidCollectorVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidProperty;
our @ISA = qw(MethodFault);

our @property_list = (
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('InvalidProperty', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PropertyFilterSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['propSet', 'PropertySpec', 1, 1],
   ['objectSet', 'ObjectSpec', 1, 1],
);


VIMRuntime::make_get_set('PropertyFilterSpec', 'propSet', 'objectSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPropertyFilterSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PropertyFilterSpec', 'PropertyFilterSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPropertyFilterSpec', 'PropertyFilterSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PropertySpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['type', undef, undef, 1],
   ['all', 'boolean', undef, 0],
   ['pathSet', undef, 1, 0],
);


VIMRuntime::make_get_set('PropertySpec', 'type', 'all', 'pathSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPropertySpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PropertySpec', 'PropertySpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPropertySpec', 'PropertySpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ObjectSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['obj', 'ManagedObjectReference', undef, 1],
   ['skip', 'boolean', undef, 0],
   ['selectSet', 'SelectionSpec', 1, 0],
);


VIMRuntime::make_get_set('ObjectSpec', 'obj', 'skip', 'selectSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfObjectSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ObjectSpec', 'ObjectSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfObjectSpec', 'ObjectSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SelectionSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 0],
);


VIMRuntime::make_get_set('SelectionSpec', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfSelectionSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['SelectionSpec', 'SelectionSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfSelectionSpec', 'SelectionSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TraversalSpec;
our @ISA = qw(SelectionSpec);

our @property_list = (
   ['type', undef, undef, 1],
   ['path', undef, undef, 1],
   ['skip', 'boolean', undef, 0],
   ['selectSet', 'SelectionSpec', 1, 0],
);


VIMRuntime::make_get_set('TraversalSpec', 'type', 'path', 'skip', 'selectSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ObjectContent;
our @ISA = qw(DynamicData);

our @property_list = (
   ['obj', 'ManagedObjectReference', undef, 1],
   ['propSet', 'DynamicProperty', 1, 0],
   ['missingSet', 'MissingProperty', 1, 0],
);


VIMRuntime::make_get_set('ObjectContent', 'obj', 'propSet', 'missingSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfObjectContent;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ObjectContent', 'ObjectContent', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfObjectContent', 'ObjectContent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UpdateSet;
our @ISA = qw(DynamicData);

our @property_list = (
   ['version', undef, undef, 1],
   ['filterSet', 'PropertyFilterUpdate', 1, 0],
);


VIMRuntime::make_get_set('UpdateSet', 'version', 'filterSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PropertyFilterUpdate;
our @ISA = qw(DynamicData);

our @property_list = (
   ['filter', 'ManagedObjectReference', undef, 1],
   ['objectSet', 'ObjectUpdate', 1, 0],
   ['missingSet', 'MissingObject', 1, 0],
);


VIMRuntime::make_get_set('PropertyFilterUpdate', 'filter', 'objectSet', 'missingSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPropertyFilterUpdate;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PropertyFilterUpdate', 'PropertyFilterUpdate', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPropertyFilterUpdate', 'PropertyFilterUpdate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ObjectUpdate;
our @ISA = qw(DynamicData);

our @property_list = (
   ['kind', 'ObjectUpdateKind', undef, 1],
   ['obj', 'ManagedObjectReference', undef, 1],
   ['changeSet', 'PropertyChange', 1, 0],
   ['missingSet', 'MissingProperty', 1, 0],
);


VIMRuntime::make_get_set('ObjectUpdate', 'kind', 'obj', 'changeSet', 'missingSet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfObjectUpdate;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ObjectUpdate', 'ObjectUpdate', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfObjectUpdate', 'ObjectUpdate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PropertyChange;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['op', 'PropertyChangeOp', undef, 1],
   ['val', 'anyType', undef, 0],
);


VIMRuntime::make_get_set('PropertyChange', 'name', 'op', 'val');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPropertyChange;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PropertyChange', 'PropertyChange', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPropertyChange', 'PropertyChange');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MissingProperty;
our @ISA = qw(DynamicData);

our @property_list = (
   ['path', undef, undef, 1],
   ['fault', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('MissingProperty', 'path', 'fault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfMissingProperty;
our @ISA = qw(ComplexType);

our @property_list = (
   ['MissingProperty', 'MissingProperty', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfMissingProperty', 'MissingProperty');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MissingObject;
our @ISA = qw(DynamicData);

our @property_list = (
   ['obj', 'ManagedObjectReference', undef, 1],
   ['fault', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('MissingObject', 'obj', 'fault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfMissingObject;
our @ISA = qw(ComplexType);

our @property_list = (
   ['MissingObject', 'MissingObject', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfMissingObject', 'MissingObject');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LocalizedMethodFault;
our @ISA = qw(DynamicData);

our @property_list = (
   ['fault', 'MethodFault', undef, 1],
   ['localizedMessage', undef, undef, 1],
);


VIMRuntime::make_get_set('LocalizedMethodFault', 'fault', 'localizedMessage');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MethodFault;
our @ISA = qw(ComplexType);

our @property_list = (
   ['dynamicType', undef, undef, 0],
   ['dynamicProperty', 'DynamicProperty', 1, 0],
);


VIMRuntime::make_get_set('MethodFault', 'dynamicType', 'dynamicProperty');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RuntimeFault;
our @ISA = qw(MethodFault);

our @property_list = (
);


VIMRuntime::make_get_set('RuntimeFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AboutInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['fullName', undef, undef, 1],
   ['vendor', undef, undef, 1],
   ['version', undef, undef, 1],
   ['build', undef, undef, 1],
   ['localeVersion', undef, undef, 0],
   ['localeBuild', undef, undef, 0],
   ['osType', undef, undef, 1],
   ['productLineId', undef, undef, 1],
   ['apiType', undef, undef, 1],
   ['apiVersion', undef, undef, 1],
);


VIMRuntime::make_get_set('AboutInfo', 'name', 'fullName', 'vendor', 'version', 'build', 'localeVersion', 'localeBuild', 'osType', 'productLineId', 'apiType', 'apiVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AuthorizationDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['privilege', 'ElementDescription', 1, 1],
   ['privilegeGroup', 'ElementDescription', 1, 1],
);


VIMRuntime::make_get_set('AuthorizationDescription', 'privilege', 'privilegeGroup');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package Permission;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 0],
   ['principal', undef, undef, 1],
   ['group', 'boolean', undef, 1],
   ['roleId', undef, undef, 1],
   ['propagate', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('Permission', 'entity', 'principal', 'group', 'roleId', 'propagate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPermission;
our @ISA = qw(ComplexType);

our @property_list = (
   ['Permission', 'Permission', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPermission', 'Permission');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AuthorizationRole;
our @ISA = qw(DynamicData);

our @property_list = (
   ['roleId', undef, undef, 1],
   ['system', 'boolean', undef, 1],
   ['name', undef, undef, 1],
   ['info', 'Description', undef, 1],
   ['privilege', undef, 1, 0],
);


VIMRuntime::make_get_set('AuthorizationRole', 'roleId', 'system', 'name', 'info', 'privilege');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAuthorizationRole;
our @ISA = qw(ComplexType);

our @property_list = (
   ['AuthorizationRole', 'AuthorizationRole', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAuthorizationRole', 'AuthorizationRole');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AuthorizationPrivilege;
our @ISA = qw(DynamicData);

our @property_list = (
   ['privId', undef, undef, 1],
   ['onParent', 'boolean', undef, 1],
   ['name', undef, undef, 1],
   ['privGroupName', undef, undef, 1],
);


VIMRuntime::make_get_set('AuthorizationPrivilege', 'privId', 'onParent', 'name', 'privGroupName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAuthorizationPrivilege;
our @ISA = qw(ComplexType);

our @property_list = (
   ['AuthorizationPrivilege', 'AuthorizationPrivilege', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAuthorizationPrivilege', 'AuthorizationPrivilege');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package Capability;
our @ISA = qw(DynamicData);

our @property_list = (
   ['provisioningSupported', 'boolean', undef, 1],
   ['multiHostSupported', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('Capability', 'provisioningSupported', 'multiHostSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterComputeResourceSummary;
our @ISA = qw(ComputeResourceSummary);

our @property_list = (
   ['currentFailoverLevel', undef, undef, 1],
   ['numVmotions', undef, undef, 1],
);


VIMRuntime::make_get_set('ClusterComputeResourceSummary', 'currentFailoverLevel', 'numVmotions');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ComputeResourceSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['totalCpu', undef, undef, 1],
   ['totalMemory', undef, undef, 1],
   ['numCpuCores', undef, undef, 1],
   ['numCpuThreads', undef, undef, 1],
   ['effectiveCpu', undef, undef, 1],
   ['effectiveMemory', undef, undef, 1],
   ['numHosts', undef, undef, 1],
   ['numEffectiveHosts', undef, undef, 1],
   ['overallStatus', 'ManagedEntityStatus', undef, 1],
);


VIMRuntime::make_get_set('ComputeResourceSummary', 'totalCpu', 'totalMemory', 'numCpuCores', 'numCpuThreads', 'effectiveCpu', 'effectiveMemory', 'numHosts', 'numEffectiveHosts', 'overallStatus');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldDef;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['name', undef, undef, 1],
   ['type', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomFieldDef', 'key', 'name', 'type');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfCustomFieldDef;
our @ISA = qw(ComplexType);

our @property_list = (
   ['CustomFieldDef', 'CustomFieldDef', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfCustomFieldDef', 'CustomFieldDef');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldValue;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomFieldValue', 'key');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfCustomFieldValue;
our @ISA = qw(ComplexType);

our @property_list = (
   ['CustomFieldValue', 'CustomFieldValue', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfCustomFieldValue', 'CustomFieldValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldStringValue;
our @ISA = qw(CustomFieldValue);

our @property_list = (
   ['value', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomFieldStringValue', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationSpecInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['description', undef, undef, 1],
   ['type', undef, undef, 1],
   ['changeVersion', undef, undef, 0],
   ['lastUpdateTime', undef, undef, 0],
);


VIMRuntime::make_get_set('CustomizationSpecInfo', 'name', 'description', 'type', 'changeVersion', 'lastUpdateTime');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfCustomizationSpecInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['CustomizationSpecInfo', 'CustomizationSpecInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfCustomizationSpecInfo', 'CustomizationSpecInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationSpecItem;
our @ISA = qw(DynamicData);

our @property_list = (
   ['info', 'CustomizationSpecInfo', undef, 1],
   ['spec', 'CustomizationSpec', undef, 1],
);


VIMRuntime::make_get_set('CustomizationSpecItem', 'info', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['datastore', 'ManagedObjectReference', undef, 0],
   ['name', undef, undef, 1],
   ['url', undef, undef, 1],
   ['capacity', undef, undef, 1],
   ['freeSpace', undef, undef, 1],
   ['accessible', 'boolean', undef, 1],
   ['multipleHostAccess', 'boolean', undef, 0],
   ['type', undef, undef, 1],
);


VIMRuntime::make_get_set('DatastoreSummary', 'datastore', 'name', 'url', 'capacity', 'freeSpace', 'accessible', 'multipleHostAccess', 'type');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['url', undef, undef, 1],
   ['freeSpace', undef, undef, 1],
   ['maxFileSize', undef, undef, 1],
);


VIMRuntime::make_get_set('DatastoreInfo', 'name', 'url', 'freeSpace', 'maxFileSize');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreCapability;
our @ISA = qw(DynamicData);

our @property_list = (
   ['directoryHierarchySupported', 'boolean', undef, 1],
   ['rawDiskMappingsSupported', 'boolean', undef, 1],
   ['perFileThinProvisioningSupported', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('DatastoreCapability', 'directoryHierarchySupported', 'rawDiskMappingsSupported', 'perFileThinProvisioningSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreHostMount;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', 'ManagedObjectReference', undef, 1],
   ['mountInfo', 'HostMountInfo', undef, 1],
);


VIMRuntime::make_get_set('DatastoreHostMount', 'key', 'mountInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfDatastoreHostMount;
our @ISA = qw(ComplexType);

our @property_list = (
   ['DatastoreHostMount', 'DatastoreHostMount', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfDatastoreHostMount', 'DatastoreHostMount');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package Description;
our @ISA = qw(DynamicData);

our @property_list = (
   ['label', undef, undef, 1],
   ['summary', undef, undef, 1],
);


VIMRuntime::make_get_set('Description', 'label', 'summary');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DiagnosticManagerLogDescriptor;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['fileName', undef, undef, 1],
   ['creator', undef, undef, 1],
   ['format', undef, undef, 1],
   ['mimeType', undef, undef, 1],
   ['info', 'Description', undef, 1],
);


VIMRuntime::make_get_set('DiagnosticManagerLogDescriptor', 'key', 'fileName', 'creator', 'format', 'mimeType', 'info');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfDiagnosticManagerLogDescriptor;
our @ISA = qw(ComplexType);

our @property_list = (
   ['DiagnosticManagerLogDescriptor', 'DiagnosticManagerLogDescriptor', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfDiagnosticManagerLogDescriptor', 'DiagnosticManagerLogDescriptor');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DiagnosticManagerLogHeader;
our @ISA = qw(DynamicData);

our @property_list = (
   ['lineStart', undef, undef, 1],
   ['lineEnd', undef, undef, 1],
   ['lineText', undef, 1, 0],
);


VIMRuntime::make_get_set('DiagnosticManagerLogHeader', 'lineStart', 'lineEnd', 'lineText');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DiagnosticManagerBundleInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['system', 'ManagedObjectReference', undef, 0],
   ['url', undef, undef, 1],
);


VIMRuntime::make_get_set('DiagnosticManagerBundleInfo', 'system', 'url');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfDiagnosticManagerBundleInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['DiagnosticManagerBundleInfo', 'DiagnosticManagerBundleInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfDiagnosticManagerBundleInfo', 'DiagnosticManagerBundleInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ElementDescription;
our @ISA = qw(Description);

our @property_list = (
   ['key', undef, undef, 1],
);


VIMRuntime::make_get_set('ElementDescription', 'key');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfElementDescription;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ElementDescription', 'ElementDescription', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfElementDescription', 'ElementDescription');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostServiceTicket;
our @ISA = qw(DynamicData);

our @property_list = (
   ['host', undef, undef, 0],
   ['port', undef, undef, 0],
   ['service', undef, undef, 1],
   ['serviceVersion', undef, undef, 1],
   ['sessionId', undef, undef, 1],
);


VIMRuntime::make_get_set('HostServiceTicket', 'host', 'port', 'service', 'serviceVersion', 'sessionId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseSource;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('LicenseSource');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseServerSource;
our @ISA = qw(LicenseSource);

our @property_list = (
   ['licenseServer', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseServerSource', 'licenseServer');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LocalLicenseSource;
our @ISA = qw(LicenseSource);

our @property_list = (
   ['licenseKeys', undef, undef, 1],
);


VIMRuntime::make_get_set('LocalLicenseSource', 'licenseKeys');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseFeatureInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['featureName', undef, undef, 1],
   ['state', 'LicenseFeatureInfoState', undef, 0],
   ['costUnit', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseFeatureInfo', 'key', 'featureName', 'state', 'costUnit');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfLicenseFeatureInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['LicenseFeatureInfo', 'LicenseFeatureInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfLicenseFeatureInfo', 'LicenseFeatureInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseReservationInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['state', 'LicenseReservationInfoState', undef, 1],
   ['required', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseReservationInfo', 'key', 'state', 'required');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfLicenseReservationInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['LicenseReservationInfo', 'LicenseReservationInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfLicenseReservationInfo', 'LicenseReservationInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseAvailabilityInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['feature', 'LicenseFeatureInfo', undef, 1],
   ['total', undef, undef, 1],
   ['available', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseAvailabilityInfo', 'feature', 'total', 'available');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfLicenseAvailabilityInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['LicenseAvailabilityInfo', 'LicenseAvailabilityInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfLicenseAvailabilityInfo', 'LicenseAvailabilityInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseUsageInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['source', 'LicenseSource', undef, 1],
   ['sourceAvailable', 'boolean', undef, 1],
   ['reservationInfo', 'LicenseReservationInfo', 1, 0],
   ['featureInfo', 'LicenseFeatureInfo', 1, 0],
);


VIMRuntime::make_get_set('LicenseUsageInfo', 'source', 'sourceAvailable', 'reservationInfo', 'featureInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MethodDescription;
our @ISA = qw(Description);

our @property_list = (
   ['key', undef, undef, 1],
);


VIMRuntime::make_get_set('MethodDescription', 'key');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NetworkSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['network', 'ManagedObjectReference', undef, 0],
   ['name', undef, undef, 1],
   ['accessible', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('NetworkSummary', 'network', 'name', 'accessible');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerformanceDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['counterType', 'ElementDescription', 1, 1],
   ['statsType', 'ElementDescription', 1, 1],
);


VIMRuntime::make_get_set('PerformanceDescription', 'counterType', 'statsType');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfProviderSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
   ['currentSupported', 'boolean', undef, 1],
   ['summarySupported', 'boolean', undef, 1],
   ['refreshRate', undef, undef, 0],
);


VIMRuntime::make_get_set('PerfProviderSummary', 'entity', 'currentSupported', 'summarySupported', 'refreshRate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfCounterInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['nameInfo', 'ElementDescription', undef, 1],
   ['groupInfo', 'ElementDescription', undef, 1],
   ['unitInfo', 'ElementDescription', undef, 1],
   ['rollupType', 'PerfSummaryType', undef, 1],
   ['statsType', 'PerfStatsType', undef, 1],
   ['associatedCounterId', undef, 1, 0],
);


VIMRuntime::make_get_set('PerfCounterInfo', 'key', 'nameInfo', 'groupInfo', 'unitInfo', 'rollupType', 'statsType', 'associatedCounterId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfCounterInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfCounterInfo', 'PerfCounterInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfCounterInfo', 'PerfCounterInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfMetricId;
our @ISA = qw(DynamicData);

our @property_list = (
   ['counterId', undef, undef, 1],
   ['instance', undef, undef, 1],
);


VIMRuntime::make_get_set('PerfMetricId', 'counterId', 'instance');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfMetricId;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfMetricId', 'PerfMetricId', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfMetricId', 'PerfMetricId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfQuerySpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
   ['startTime', undef, undef, 0],
   ['endTime', undef, undef, 0],
   ['maxSample', undef, undef, 0],
   ['metricId', 'PerfMetricId', 1, 0],
   ['intervalId', undef, undef, 0],
   ['format', undef, undef, 0],
);


VIMRuntime::make_get_set('PerfQuerySpec', 'entity', 'startTime', 'endTime', 'maxSample', 'metricId', 'intervalId', 'format');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfQuerySpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfQuerySpec', 'PerfQuerySpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfQuerySpec', 'PerfQuerySpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfSampleInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['timestamp', undef, undef, 1],
   ['interval', undef, undef, 1],
);


VIMRuntime::make_get_set('PerfSampleInfo', 'timestamp', 'interval');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfSampleInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfSampleInfo', 'PerfSampleInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfSampleInfo', 'PerfSampleInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfMetricSeries;
our @ISA = qw(DynamicData);

our @property_list = (
   ['id', 'PerfMetricId', undef, 1],
);


VIMRuntime::make_get_set('PerfMetricSeries', 'id');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfMetricSeries;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfMetricSeries', 'PerfMetricSeries', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfMetricSeries', 'PerfMetricSeries');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfMetricIntSeries;
our @ISA = qw(PerfMetricSeries);

our @property_list = (
   ['value', undef, 1, 0],
);


VIMRuntime::make_get_set('PerfMetricIntSeries', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfMetricSeriesCSV;
our @ISA = qw(PerfMetricSeries);

our @property_list = (
   ['value', undef, undef, 0],
);


VIMRuntime::make_get_set('PerfMetricSeriesCSV', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfMetricSeriesCSV;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfMetricSeriesCSV', 'PerfMetricSeriesCSV', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfMetricSeriesCSV', 'PerfMetricSeriesCSV');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfEntityMetricBase;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('PerfEntityMetricBase', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfEntityMetricBase;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfEntityMetricBase', 'PerfEntityMetricBase', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfEntityMetricBase', 'PerfEntityMetricBase');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfEntityMetric;
our @ISA = qw(PerfEntityMetricBase);

our @property_list = (
   ['sampleInfo', 'PerfSampleInfo', 1, 0],
   ['value', 'PerfMetricSeries', 1, 0],
);


VIMRuntime::make_get_set('PerfEntityMetric', 'sampleInfo', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfEntityMetricCSV;
our @ISA = qw(PerfEntityMetricBase);

our @property_list = (
   ['sampleInfoCSV', undef, undef, 1],
   ['value', 'PerfMetricSeriesCSV', 1, 0],
);


VIMRuntime::make_get_set('PerfEntityMetricCSV', 'sampleInfoCSV', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfEntityMetricCSV;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfEntityMetricCSV', 'PerfEntityMetricCSV', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfEntityMetricCSV', 'PerfEntityMetricCSV');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfCompositeMetric;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'PerfEntityMetricBase', undef, 0],
   ['childEntity', 'PerfEntityMetricBase', 1, 0],
);


VIMRuntime::make_get_set('PerfCompositeMetric', 'entity', 'childEntity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PerfInterval;
our @ISA = qw(DynamicData);

our @property_list = (
   ['samplingPeriod', undef, undef, 1],
   ['name', undef, undef, 1],
   ['length', undef, undef, 1],
);


VIMRuntime::make_get_set('PerfInterval', 'samplingPeriod', 'name', 'length');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPerfInterval;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PerfInterval', 'PerfInterval', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPerfInterval', 'PerfInterval');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourceAllocationInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['reservation', undef, undef, 0],
   ['expandableReservation', 'boolean', undef, 0],
   ['limit', undef, undef, 0],
   ['shares', 'SharesInfo', undef, 0],
);


VIMRuntime::make_get_set('ResourceAllocationInfo', 'reservation', 'expandableReservation', 'limit', 'shares');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourceConfigSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 0],
   ['changeVersion', undef, undef, 0],
   ['lastModified', undef, undef, 0],
   ['cpuAllocation', 'ResourceAllocationInfo', undef, 1],
   ['memoryAllocation', 'ResourceAllocationInfo', undef, 1],
);


VIMRuntime::make_get_set('ResourceConfigSpec', 'entity', 'changeVersion', 'lastModified', 'cpuAllocation', 'memoryAllocation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfResourceConfigSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ResourceConfigSpec', 'ResourceConfigSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfResourceConfigSpec', 'ResourceConfigSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolResourceUsage;
our @ISA = qw(DynamicData);

our @property_list = (
   ['reservationUsed', undef, undef, 1],
   ['reservationUsedForVm', undef, undef, 1],
   ['unreservedForPool', undef, undef, 1],
   ['unreservedForVm', undef, undef, 1],
   ['overallUsage', undef, undef, 1],
   ['maxUsage', undef, undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolResourceUsage', 'reservationUsed', 'reservationUsedForVm', 'unreservedForPool', 'unreservedForVm', 'overallUsage', 'maxUsage');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolRuntimeInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['memory', 'ResourcePoolResourceUsage', undef, 1],
   ['cpu', 'ResourcePoolResourceUsage', undef, 1],
   ['overallStatus', 'ManagedEntityStatus', undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolRuntimeInfo', 'memory', 'cpu', 'overallStatus');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['config', 'ResourceConfigSpec', undef, 1],
   ['runtime', 'ResourcePoolRuntimeInfo', undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolSummary', 'name', 'config', 'runtime');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionCompatibility;
our @ISA = qw(DynamicData);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 1],
   ['compatibility', undef, 1, 0],
);


VIMRuntime::make_get_set('HostVMotionCompatibility', 'host', 'compatibility');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostVMotionCompatibility;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostVMotionCompatibility', 'HostVMotionCompatibility', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostVMotionCompatibility', 'HostVMotionCompatibility');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ServiceContent;
our @ISA = qw(DynamicData);

our @property_list = (
   ['rootFolder', 'ManagedObjectReference', undef, 1],
   ['propertyCollector', 'ManagedObjectReference', undef, 1],
   ['about', 'AboutInfo', undef, 1],
   ['setting', 'ManagedObjectReference', undef, 0],
   ['userDirectory', 'ManagedObjectReference', undef, 0],
   ['sessionManager', 'ManagedObjectReference', undef, 0],
   ['authorizationManager', 'ManagedObjectReference', undef, 0],
   ['perfManager', 'ManagedObjectReference', undef, 0],
   ['scheduledTaskManager', 'ManagedObjectReference', undef, 0],
   ['alarmManager', 'ManagedObjectReference', undef, 0],
   ['eventManager', 'ManagedObjectReference', undef, 0],
   ['taskManager', 'ManagedObjectReference', undef, 0],
   ['customizationSpecManager', 'ManagedObjectReference', undef, 0],
   ['customFieldsManager', 'ManagedObjectReference', undef, 0],
   ['accountManager', 'ManagedObjectReference', undef, 0],
   ['diagnosticManager', 'ManagedObjectReference', undef, 0],
   ['licenseManager', 'ManagedObjectReference', undef, 0],
   ['searchIndex', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('ServiceContent', 'rootFolder', 'propertyCollector', 'about', 'setting', 'userDirectory', 'sessionManager', 'authorizationManager', 'perfManager', 'scheduledTaskManager', 'alarmManager', 'eventManager', 'taskManager', 'customizationSpecManager', 'customFieldsManager', 'accountManager', 'diagnosticManager', 'licenseManager', 'searchIndex');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SessionManagerLocalTicket;
our @ISA = qw(DynamicData);

our @property_list = (
   ['userName', undef, undef, 1],
   ['passwordFilePath', undef, undef, 1],
);


VIMRuntime::make_get_set('SessionManagerLocalTicket', 'userName', 'passwordFilePath');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserSession;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['userName', undef, undef, 1],
   ['fullName', undef, undef, 1],
   ['loginTime', undef, undef, 1],
   ['lastActiveTime', undef, undef, 1],
   ['locale', undef, undef, 1],
   ['messageLocale', undef, undef, 1],
);


VIMRuntime::make_get_set('UserSession', 'key', 'userName', 'fullName', 'loginTime', 'lastActiveTime', 'locale', 'messageLocale');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfUserSession;
our @ISA = qw(ComplexType);

our @property_list = (
   ['UserSession', 'UserSession', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfUserSession', 'UserSession');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SharesInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['shares', undef, undef, 1],
   ['level', 'SharesLevel', undef, 1],
);


VIMRuntime::make_get_set('SharesInfo', 'shares', 'level');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['methodInfo', 'ElementDescription', 1, 1],
   ['state', 'ElementDescription', 1, 1],
   ['reason', 'TypeDescription', 1, 1],
);


VIMRuntime::make_get_set('TaskDescription', 'methodInfo', 'state', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskFilterSpecByEntity;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
   ['recursion', 'TaskFilterSpecRecursionOption', undef, 1],
);


VIMRuntime::make_get_set('TaskFilterSpecByEntity', 'entity', 'recursion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskFilterSpecByTime;
our @ISA = qw(DynamicData);

our @property_list = (
   ['timeType', 'TaskFilterSpecTimeOption', undef, 1],
   ['beginTime', undef, undef, 0],
   ['endTime', undef, undef, 0],
);


VIMRuntime::make_get_set('TaskFilterSpecByTime', 'timeType', 'beginTime', 'endTime');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskFilterSpecByUsername;
our @ISA = qw(DynamicData);

our @property_list = (
   ['systemUser', 'boolean', undef, 1],
   ['userList', undef, 1, 0],
);


VIMRuntime::make_get_set('TaskFilterSpecByUsername', 'systemUser', 'userList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskFilterSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'TaskFilterSpecByEntity', undef, 0],
   ['time', 'TaskFilterSpecByTime', undef, 0],
   ['userName', 'TaskFilterSpecByUsername', undef, 0],
   ['state', 'TaskInfoState', 1, 0],
   ['alarm', 'ManagedObjectReference', undef, 0],
   ['scheduledTask', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('TaskFilterSpec', 'entity', 'time', 'userName', 'state', 'alarm', 'scheduledTask');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfTaskInfoState;
our @ISA = qw(ComplexType);

our @property_list = (
   ['TaskInfoState', 'TaskInfoState', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfTaskInfoState', 'TaskInfoState');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['task', 'ManagedObjectReference', undef, 1],
   ['name', undef, undef, 0],
   ['descriptionId', undef, undef, 1],
   ['entity', 'ManagedObjectReference', undef, 0],
   ['entityName', undef, undef, 0],
   ['locked', 'ManagedObjectReference', 1, 0],
   ['state', 'TaskInfoState', undef, 1],
   ['cancelled', 'boolean', undef, 1],
   ['cancelable', 'boolean', undef, 1],
   ['error', 'LocalizedMethodFault', undef, 0],
   ['result', 'anyType', undef, 0],
   ['progress', undef, undef, 0],
   ['reason', 'TaskReason', undef, 1],
   ['queueTime', undef, undef, 1],
   ['startTime', undef, undef, 0],
   ['completeTime', undef, undef, 0],
   ['eventChainId', undef, undef, 1],
);


VIMRuntime::make_get_set('TaskInfo', 'key', 'task', 'name', 'descriptionId', 'entity', 'entityName', 'locked', 'state', 'cancelled', 'cancelable', 'error', 'result', 'progress', 'reason', 'queueTime', 'startTime', 'completeTime', 'eventChainId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfTaskInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['TaskInfo', 'TaskInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfTaskInfo', 'TaskInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskReason;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('TaskReason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskReasonSystem;
our @ISA = qw(TaskReason);

our @property_list = (
);


VIMRuntime::make_get_set('TaskReasonSystem');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskReasonUser;
our @ISA = qw(TaskReason);

our @property_list = (
   ['userName', undef, undef, 1],
);


VIMRuntime::make_get_set('TaskReasonUser', 'userName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskReasonAlarm;
our @ISA = qw(TaskReason);

our @property_list = (
   ['alarmName', undef, undef, 1],
   ['alarm', 'ManagedObjectReference', undef, 1],
   ['entityName', undef, undef, 1],
   ['entity', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('TaskReasonAlarm', 'alarmName', 'alarm', 'entityName', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskReasonSchedule;
our @ISA = qw(TaskReason);

our @property_list = (
   ['name', undef, undef, 1],
   ['scheduledTask', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('TaskReasonSchedule', 'name', 'scheduledTask');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TypeDescription;
our @ISA = qw(Description);

our @property_list = (
   ['key', undef, undef, 1],
);


VIMRuntime::make_get_set('TypeDescription', 'key');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfTypeDescription;
our @ISA = qw(ComplexType);

our @property_list = (
   ['TypeDescription', 'TypeDescription', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfTypeDescription', 'TypeDescription');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserSearchResult;
our @ISA = qw(DynamicData);

our @property_list = (
   ['principal', undef, undef, 1],
   ['fullName', undef, undef, 0],
   ['group', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('UserSearchResult', 'principal', 'fullName', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfUserSearchResult;
our @ISA = qw(ComplexType);

our @property_list = (
   ['UserSearchResult', 'UserSearchResult', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfUserSearchResult', 'UserSearchResult');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PosixUserSearchResult;
our @ISA = qw(UserSearchResult);

our @property_list = (
   ['id', undef, undef, 1],
   ['shellAccess', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('PosixUserSearchResult', 'id', 'shellAccess');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineMksTicket;
our @ISA = qw(DynamicData);

our @property_list = (
   ['ticket', undef, undef, 1],
   ['cfgFile', undef, undef, 1],
   ['host', undef, undef, 0],
   ['port', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineMksTicket', 'ticket', 'cfgFile', 'host', 'port');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package Action;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('Action');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MethodActionArgument;
our @ISA = qw(DynamicData);

our @property_list = (
   ['value', 'anyType', undef, 0],
);


VIMRuntime::make_get_set('MethodActionArgument', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfMethodActionArgument;
our @ISA = qw(ComplexType);

our @property_list = (
   ['MethodActionArgument', 'MethodActionArgument', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfMethodActionArgument', 'MethodActionArgument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MethodAction;
our @ISA = qw(Action);

our @property_list = (
   ['name', undef, undef, 1],
   ['argument', 'MethodActionArgument', 1, 0],
);


VIMRuntime::make_get_set('MethodAction', 'name', 'argument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SendEmailAction;
our @ISA = qw(Action);

our @property_list = (
   ['toList', undef, undef, 1],
   ['ccList', undef, undef, 1],
   ['subject', undef, undef, 1],
   ['body', undef, undef, 1],
);


VIMRuntime::make_get_set('SendEmailAction', 'toList', 'ccList', 'subject', 'body');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SendSNMPAction;
our @ISA = qw(Action);

our @property_list = (
);


VIMRuntime::make_get_set('SendSNMPAction');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RunScriptAction;
our @ISA = qw(Action);

our @property_list = (
   ['script', undef, undef, 1],
);


VIMRuntime::make_get_set('RunScriptAction', 'script');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmAction;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('AlarmAction');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAlarmAction;
our @ISA = qw(ComplexType);

our @property_list = (
   ['AlarmAction', 'AlarmAction', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAlarmAction', 'AlarmAction');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmTriggeringAction;
our @ISA = qw(AlarmAction);

our @property_list = (
   ['action', 'Action', undef, 1],
   ['green2yellow', 'boolean', undef, 1],
   ['yellow2red', 'boolean', undef, 1],
   ['red2yellow', 'boolean', undef, 1],
   ['yellow2green', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('AlarmTriggeringAction', 'action', 'green2yellow', 'yellow2red', 'red2yellow', 'yellow2green');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GroupAlarmAction;
our @ISA = qw(AlarmAction);

our @property_list = (
   ['action', 'AlarmAction', 1, 1],
);


VIMRuntime::make_get_set('GroupAlarmAction', 'action');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['expr', 'TypeDescription', 1, 1],
   ['stateOperator', 'ElementDescription', 1, 1],
   ['metricOperator', 'ElementDescription', 1, 1],
   ['hostSystemConnectionState', 'ElementDescription', 1, 1],
   ['virtualMachinePowerState', 'ElementDescription', 1, 1],
   ['entityStatus', 'ElementDescription', 1, 1],
   ['action', 'TypeDescription', 1, 1],
);


VIMRuntime::make_get_set('AlarmDescription', 'expr', 'stateOperator', 'metricOperator', 'hostSystemConnectionState', 'virtualMachinePowerState', 'entityStatus', 'action');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmExpression;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('AlarmExpression');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAlarmExpression;
our @ISA = qw(ComplexType);

our @property_list = (
   ['AlarmExpression', 'AlarmExpression', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAlarmExpression', 'AlarmExpression');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AndAlarmExpression;
our @ISA = qw(AlarmExpression);

our @property_list = (
   ['expression', 'AlarmExpression', 1, 1],
);


VIMRuntime::make_get_set('AndAlarmExpression', 'expression');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package OrAlarmExpression;
our @ISA = qw(AlarmExpression);

our @property_list = (
   ['expression', 'AlarmExpression', 1, 1],
);


VIMRuntime::make_get_set('OrAlarmExpression', 'expression');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package StateAlarmExpression;
our @ISA = qw(AlarmExpression);

our @property_list = (
   ['operator', 'StateAlarmOperator', undef, 1],
   ['type', undef, undef, 1],
   ['statePath', undef, undef, 1],
   ['yellow', undef, undef, 0],
   ['red', undef, undef, 0],
);


VIMRuntime::make_get_set('StateAlarmExpression', 'operator', 'type', 'statePath', 'yellow', 'red');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MetricAlarmExpression;
our @ISA = qw(AlarmExpression);

our @property_list = (
   ['operator', 'MetricAlarmOperator', undef, 1],
   ['type', undef, undef, 1],
   ['metric', 'PerfMetricId', undef, 1],
   ['yellow', undef, undef, 0],
   ['red', undef, undef, 0],
);


VIMRuntime::make_get_set('MetricAlarmExpression', 'operator', 'type', 'metric', 'yellow', 'red');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmInfo;
our @ISA = qw(AlarmSpec);

our @property_list = (
   ['key', undef, undef, 1],
   ['alarm', 'ManagedObjectReference', undef, 1],
   ['entity', 'ManagedObjectReference', undef, 1],
   ['lastModifiedTime', undef, undef, 1],
   ['lastModifiedUser', undef, undef, 1],
   ['creationEventId', undef, undef, 1],
);


VIMRuntime::make_get_set('AlarmInfo', 'key', 'alarm', 'entity', 'lastModifiedTime', 'lastModifiedUser', 'creationEventId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmSetting;
our @ISA = qw(DynamicData);

our @property_list = (
   ['toleranceRange', undef, undef, 1],
   ['reportingFrequency', undef, undef, 1],
);


VIMRuntime::make_get_set('AlarmSetting', 'toleranceRange', 'reportingFrequency');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['description', undef, undef, 1],
   ['enabled', 'boolean', undef, 1],
   ['expression', 'AlarmExpression', undef, 1],
   ['action', 'AlarmAction', undef, 0],
   ['setting', 'AlarmSetting', undef, 0],
);


VIMRuntime::make_get_set('AlarmSpec', 'name', 'description', 'enabled', 'expression', 'action', 'setting');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmState;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['entity', 'ManagedObjectReference', undef, 1],
   ['alarm', 'ManagedObjectReference', undef, 1],
   ['overallStatus', 'ManagedEntityStatus', undef, 1],
   ['time', undef, undef, 1],
);


VIMRuntime::make_get_set('AlarmState', 'key', 'entity', 'alarm', 'overallStatus', 'time');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAlarmState;
our @ISA = qw(ComplexType);

our @property_list = (
   ['AlarmState', 'AlarmState', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAlarmState', 'AlarmState');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['dasConfig', 'ClusterDasConfigInfo', undef, 1],
   ['dasVmConfig', 'ClusterDasVmConfigInfo', 1, 0],
   ['drsConfig', 'ClusterDrsConfigInfo', undef, 1],
   ['drsVmConfig', 'ClusterDrsVmConfigInfo', 1, 0],
   ['rule', 'ClusterRuleInfo', 1, 0],
);


VIMRuntime::make_get_set('ClusterConfigInfo', 'dasConfig', 'dasVmConfig', 'drsConfig', 'drsVmConfig', 'rule');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDrsConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['enabled', 'boolean', undef, 0],
   ['defaultVmBehavior', 'DrsBehavior', undef, 0],
   ['vmotionRate', undef, undef, 0],
   ['option', 'OptionValue', 1, 0],
);


VIMRuntime::make_get_set('ClusterDrsConfigInfo', 'enabled', 'defaultVmBehavior', 'vmotionRate', 'option');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDrsVmConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', 'ManagedObjectReference', undef, 1],
   ['enabled', 'boolean', undef, 0],
   ['behavior', 'DrsBehavior', undef, 0],
);


VIMRuntime::make_get_set('ClusterDrsVmConfigInfo', 'key', 'enabled', 'behavior');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterDrsVmConfigInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterDrsVmConfigInfo', 'ClusterDrsVmConfigInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterDrsVmConfigInfo', 'ClusterDrsVmConfigInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterConfigSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['dasConfig', 'ClusterDasConfigInfo', undef, 0],
   ['dasVmConfigSpec', 'ClusterDasVmConfigSpec', 1, 0],
   ['drsConfig', 'ClusterDrsConfigInfo', undef, 0],
   ['drsVmConfigSpec', 'ClusterDrsVmConfigSpec', 1, 0],
   ['rulesSpec', 'ClusterRuleSpec', 1, 0],
);


VIMRuntime::make_get_set('ClusterConfigSpec', 'dasConfig', 'dasVmConfigSpec', 'drsConfig', 'drsVmConfigSpec', 'rulesSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDasVmConfigSpec;
our @ISA = qw(ArrayUpdateSpec);

our @property_list = (
   ['info', 'ClusterDasVmConfigInfo', undef, 0],
);


VIMRuntime::make_get_set('ClusterDasVmConfigSpec', 'info');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterDasVmConfigSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterDasVmConfigSpec', 'ClusterDasVmConfigSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterDasVmConfigSpec', 'ClusterDasVmConfigSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDrsVmConfigSpec;
our @ISA = qw(ArrayUpdateSpec);

our @property_list = (
   ['info', 'ClusterDrsVmConfigInfo', undef, 0],
);


VIMRuntime::make_get_set('ClusterDrsVmConfigSpec', 'info');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterDrsVmConfigSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterDrsVmConfigSpec', 'ClusterDrsVmConfigSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterDrsVmConfigSpec', 'ClusterDrsVmConfigSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterRuleSpec;
our @ISA = qw(ArrayUpdateSpec);

our @property_list = (
   ['info', 'ClusterRuleInfo', undef, 0],
);


VIMRuntime::make_get_set('ClusterRuleSpec', 'info');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterRuleSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterRuleSpec', 'ClusterRuleSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterRuleSpec', 'ClusterRuleSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDasConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['enabled', 'boolean', undef, 0],
   ['failoverLevel', undef, undef, 0],
   ['admissionControlEnabled', 'boolean', undef, 0],
   ['option', 'OptionValue', 1, 0],
);


VIMRuntime::make_get_set('ClusterDasConfigInfo', 'enabled', 'failoverLevel', 'admissionControlEnabled', 'option');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDasVmConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', 'ManagedObjectReference', undef, 1],
   ['restartPriority', 'DasVmPriority', undef, 0],
   ['powerOffOnIsolation', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('ClusterDasVmConfigInfo', 'key', 'restartPriority', 'powerOffOnIsolation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterDasVmConfigInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterDasVmConfigInfo', 'ClusterDasVmConfigInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterDasVmConfigInfo', 'ClusterDasVmConfigInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDrsMigration;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['time', undef, undef, 1],
   ['vm', 'ManagedObjectReference', undef, 1],
   ['cpuLoad', undef, undef, 0],
   ['memoryLoad', undef, undef, 0],
   ['source', 'ManagedObjectReference', undef, 1],
   ['sourceCpuLoad', undef, undef, 0],
   ['sourceMemoryLoad', undef, undef, 0],
   ['destination', 'ManagedObjectReference', undef, 1],
   ['destinationCpuLoad', undef, undef, 0],
   ['destinationMemoryLoad', undef, undef, 0],
);


VIMRuntime::make_get_set('ClusterDrsMigration', 'key', 'time', 'vm', 'cpuLoad', 'memoryLoad', 'source', 'sourceCpuLoad', 'sourceMemoryLoad', 'destination', 'destinationCpuLoad', 'destinationMemoryLoad');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterDrsMigration;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterDrsMigration', 'ClusterDrsMigration', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterDrsMigration', 'ClusterDrsMigration');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDrsRecommendation;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['rating', undef, undef, 1],
   ['reason', undef, undef, 1],
   ['reasonText', undef, undef, 1],
   ['migrationList', 'ClusterDrsMigration', 1, 1],
);


VIMRuntime::make_get_set('ClusterDrsRecommendation', 'key', 'rating', 'reason', 'reasonText', 'migrationList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterDrsRecommendation;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterDrsRecommendation', 'ClusterDrsRecommendation', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterDrsRecommendation', 'ClusterDrsRecommendation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterHostRecommendation;
our @ISA = qw(DynamicData);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 1],
   ['rating', undef, undef, 1],
);


VIMRuntime::make_get_set('ClusterHostRecommendation', 'host', 'rating');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterHostRecommendation;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterHostRecommendation', 'ClusterHostRecommendation', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterHostRecommendation', 'ClusterHostRecommendation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterRuleInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 0],
   ['status', 'ManagedEntityStatus', undef, 0],
   ['enabled', 'boolean', undef, 0],
   ['name', undef, undef, 0],
);


VIMRuntime::make_get_set('ClusterRuleInfo', 'key', 'status', 'enabled', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfClusterRuleInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ClusterRuleInfo', 'ClusterRuleInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfClusterRuleInfo', 'ClusterRuleInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterAffinityRuleSpec;
our @ISA = qw(ClusterRuleInfo);

our @property_list = (
   ['vm', 'ManagedObjectReference', 1, 1],
);


VIMRuntime::make_get_set('ClusterAffinityRuleSpec', 'vm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterAntiAffinityRuleSpec;
our @ISA = qw(ClusterRuleInfo);

our @property_list = (
   ['vm', 'ManagedObjectReference', 1, 1],
);


VIMRuntime::make_get_set('ClusterAntiAffinityRuleSpec', 'vm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package Event;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['chainId', undef, undef, 1],
   ['createdTime', undef, undef, 1],
   ['userName', undef, undef, 1],
   ['datacenter', 'DatacenterEventArgument', undef, 0],
   ['computeResource', 'ComputeResourceEventArgument', undef, 0],
   ['host', 'HostEventArgument', undef, 0],
   ['vm', 'VmEventArgument', undef, 0],
   ['fullFormattedMessage', undef, undef, 0],
);


VIMRuntime::make_get_set('Event', 'key', 'chainId', 'createdTime', 'userName', 'datacenter', 'computeResource', 'host', 'vm', 'fullFormattedMessage');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfEvent;
our @ISA = qw(ComplexType);

our @property_list = (
   ['Event', 'Event', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfEvent', 'Event');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralEvent;
our @ISA = qw(Event);

our @property_list = (
   ['message', undef, undef, 1],
);


VIMRuntime::make_get_set('GeneralEvent', 'message');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralHostInfoEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
);


VIMRuntime::make_get_set('GeneralHostInfoEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralHostWarningEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
);


VIMRuntime::make_get_set('GeneralHostWarningEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralHostErrorEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
);


VIMRuntime::make_get_set('GeneralHostErrorEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralVmInfoEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
);


VIMRuntime::make_get_set('GeneralVmInfoEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralVmWarningEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
);


VIMRuntime::make_get_set('GeneralVmWarningEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralVmErrorEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
);


VIMRuntime::make_get_set('GeneralVmErrorEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GeneralUserEvent;
our @ISA = qw(GeneralEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 0],
);


VIMRuntime::make_get_set('GeneralUserEvent', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SessionEvent;
our @ISA = qw(Event);

our @property_list = (
);


VIMRuntime::make_get_set('SessionEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ServerStartedSessionEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ServerStartedSessionEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserLoginSessionEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
   ['ipAddress', undef, undef, 1],
   ['locale', undef, undef, 1],
   ['sessionId', undef, undef, 1],
);


VIMRuntime::make_get_set('UserLoginSessionEvent', 'ipAddress', 'locale', 'sessionId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserLogoutSessionEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
);


VIMRuntime::make_get_set('UserLogoutSessionEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package BadUsernameSessionEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
   ['ipAddress', undef, undef, 1],
);


VIMRuntime::make_get_set('BadUsernameSessionEvent', 'ipAddress');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlreadyAuthenticatedSessionEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
);


VIMRuntime::make_get_set('AlreadyAuthenticatedSessionEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoAccessUserEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
   ['ipAddress', undef, undef, 1],
);


VIMRuntime::make_get_set('NoAccessUserEvent', 'ipAddress');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SessionTerminatedEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
   ['sessionId', undef, undef, 1],
   ['terminatedUsername', undef, undef, 1],
);


VIMRuntime::make_get_set('SessionTerminatedEvent', 'sessionId', 'terminatedUsername');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GlobalMessageChangedEvent;
our @ISA = qw(SessionEvent);

our @property_list = (
   ['message', undef, undef, 1],
);


VIMRuntime::make_get_set('GlobalMessageChangedEvent', 'message');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UpgradeEvent;
our @ISA = qw(Event);

our @property_list = (
   ['message', undef, undef, 1],
);


VIMRuntime::make_get_set('UpgradeEvent', 'message');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InfoUpgradeEvent;
our @ISA = qw(UpgradeEvent);

our @property_list = (
);


VIMRuntime::make_get_set('InfoUpgradeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package WarningUpgradeEvent;
our @ISA = qw(UpgradeEvent);

our @property_list = (
);


VIMRuntime::make_get_set('WarningUpgradeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ErrorUpgradeEvent;
our @ISA = qw(UpgradeEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ErrorUpgradeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserUpgradeEvent;
our @ISA = qw(UpgradeEvent);

our @property_list = (
);


VIMRuntime::make_get_set('UserUpgradeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostEvent;
our @ISA = qw(Event);

our @property_list = (
);


VIMRuntime::make_get_set('HostEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConnectedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostConnectedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDisconnectedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDisconnectedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConnectionLostEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostConnectionLostEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostReconnectionFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostReconnectionFailedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedNoConnectionEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedNoConnectionEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedBadUsernameEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedBadUsernameEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedBadVersionEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedBadVersionEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedAlreadyManagedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['serverName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostCnxFailedAlreadyManagedEvent', 'serverName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedNoLicenseEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedNoLicenseEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedNetworkErrorEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedNetworkErrorEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostRemovedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostRemovedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedCcagentUpgradeEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedCcagentUpgradeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedBadCcagentEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedBadCcagentEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedAccountFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedAccountFailedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedNoAccessEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedNoAccessEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostShutdownEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['reason', undef, undef, 1],
);


VIMRuntime::make_get_set('HostShutdownEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedNotFoundEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedNotFoundEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCnxFailedTimeoutEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostCnxFailedTimeoutEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostUpgradeFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostUpgradeFailedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EnteringMaintenanceModeEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('EnteringMaintenanceModeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EnteredMaintenanceModeEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('EnteredMaintenanceModeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ExitMaintenanceModeEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ExitMaintenanceModeEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CanceledHostOperationEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('CanceledHostOperationEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TimedOutHostOperationEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('TimedOutHostOperationEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDasEnabledEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDasEnabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDasDisabledEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDasDisabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDasEnablingEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDasEnablingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDasDisablingEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDasDisablingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDasErrorEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDasErrorEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDasOkEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostDasOkEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VcAgentUpgradedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VcAgentUpgradedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VcAgentUpgradeFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VcAgentUpgradeFailedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostAddedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostAddedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostAddFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['hostname', undef, undef, 1],
);


VIMRuntime::make_get_set('HostAddFailedEvent', 'hostname');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AccountCreatedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['spec', 'HostAccountSpec', undef, 1],
   ['group', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('AccountCreatedEvent', 'spec', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AccountRemovedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['account', undef, undef, 1],
   ['group', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('AccountRemovedEvent', 'account', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserPasswordChanged;
our @ISA = qw(HostEvent);

our @property_list = (
   ['userLogin', undef, undef, 1],
);


VIMRuntime::make_get_set('UserPasswordChanged', 'userLogin');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AccountUpdatedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['spec', 'HostAccountSpec', undef, 1],
   ['group', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('AccountUpdatedEvent', 'spec', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserAssignedToGroup;
our @ISA = qw(HostEvent);

our @property_list = (
   ['userLogin', undef, undef, 1],
   ['group', undef, undef, 1],
);


VIMRuntime::make_get_set('UserAssignedToGroup', 'userLogin', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserUnassignedFromGroup;
our @ISA = qw(HostEvent);

our @property_list = (
   ['userLogin', undef, undef, 1],
   ['group', undef, undef, 1],
);


VIMRuntime::make_get_set('UserUnassignedFromGroup', 'userLogin', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastorePrincipalConfigured;
our @ISA = qw(HostEvent);

our @property_list = (
   ['datastorePrincipal', undef, undef, 1],
);


VIMRuntime::make_get_set('DatastorePrincipalConfigured', 'datastorePrincipal');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMFSDatastoreCreatedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['datastore', 'DatastoreEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VMFSDatastoreCreatedEvent', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NASDatastoreCreatedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['datastore', 'DatastoreEventArgument', undef, 1],
);


VIMRuntime::make_get_set('NASDatastoreCreatedEvent', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LocalDatastoreCreatedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['datastore', 'DatastoreEventArgument', undef, 1],
);


VIMRuntime::make_get_set('LocalDatastoreCreatedEvent', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreRemovedOnHostEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['datastore', 'DatastoreEventArgument', undef, 1],
);


VIMRuntime::make_get_set('DatastoreRemovedOnHostEvent', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreRenamedOnHostEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['oldName', undef, undef, 1],
   ['newName', undef, undef, 1],
);


VIMRuntime::make_get_set('DatastoreRenamedOnHostEvent', 'oldName', 'newName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreDiscoveredEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['datastore', 'DatastoreEventArgument', undef, 1],
);


VIMRuntime::make_get_set('DatastoreDiscoveredEvent', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DrsResourceConfigureFailedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('DrsResourceConfigureFailedEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DrsResourceConfigureSyncedEvent;
our @ISA = qw(HostEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DrsResourceConfigureSyncedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmEvent;
our @ISA = qw(Event);

our @property_list = (
   ['template', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VmEvent', 'template');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmPoweredOffEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmPoweredOffEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmPoweredOnEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmPoweredOnEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmSuspendedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmSuspendedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmStartingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmStartingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmStoppingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmStoppingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmSuspendingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmSuspendingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmResumingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmResumingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDisconnectedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmDisconnectedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDiscoveredEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmDiscoveredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmOrphanedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmOrphanedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmBeingCreatedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['configSpec', 'VirtualMachineConfigSpec', undef, 0],
);


VIMRuntime::make_get_set('VmBeingCreatedEvent', 'configSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmCreatedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmCreatedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRegisteredEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmRegisteredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmAutoRenameEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['oldName', undef, undef, 1],
   ['newName', undef, undef, 1],
);


VIMRuntime::make_get_set('VmAutoRenameEvent', 'oldName', 'newName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmBeingHotMigratedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['destHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmBeingHotMigratedEvent', 'destHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmResettingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmResettingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmStaticMacConflictEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['conflictedVm', 'VmEventArgument', undef, 1],
   ['mac', undef, undef, 1],
);


VIMRuntime::make_get_set('VmStaticMacConflictEvent', 'conflictedVm', 'mac');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmMacConflictEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['conflictedVm', 'VmEventArgument', undef, 1],
   ['mac', undef, undef, 1],
);


VIMRuntime::make_get_set('VmMacConflictEvent', 'conflictedVm', 'mac');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmBeingDeployedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['srcTemplate', 'VmEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmBeingDeployedEvent', 'srcTemplate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDeployFailedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['destDatastore', 'EntityEventArgument', undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmDeployFailedEvent', 'destDatastore', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDeployedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['srcTemplate', 'VmEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmDeployedEvent', 'srcTemplate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmMacChangedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['adapter', undef, undef, 1],
   ['oldMac', undef, undef, 1],
   ['newMac', undef, undef, 1],
);


VIMRuntime::make_get_set('VmMacChangedEvent', 'adapter', 'oldMac', 'newMac');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmMacAssignedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['adapter', undef, undef, 1],
   ['mac', undef, undef, 1],
);


VIMRuntime::make_get_set('VmMacAssignedEvent', 'adapter', 'mac');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUuidConflictEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['conflictedVm', 'VmEventArgument', undef, 1],
   ['uuid', undef, undef, 1],
);


VIMRuntime::make_get_set('VmUuidConflictEvent', 'conflictedVm', 'uuid');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmBeingMigratedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['destHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmBeingMigratedEvent', 'destHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedMigrateEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['destHost', 'HostEventArgument', undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedMigrateEvent', 'destHost', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmMigratedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['sourceHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmMigratedEvent', 'sourceHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUnsupportedStartingEvent;
our @ISA = qw(VmStartingEvent);

our @property_list = (
   ['guestId', undef, undef, 1],
);


VIMRuntime::make_get_set('VmUnsupportedStartingEvent', 'guestId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DrsVmMigratedEvent;
our @ISA = qw(VmMigratedEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DrsVmMigratedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRelocateSpecEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmRelocateSpecEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmBeingRelocatedEvent;
our @ISA = qw(VmRelocateSpecEvent);

our @property_list = (
   ['destHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmBeingRelocatedEvent', 'destHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRelocatedEvent;
our @ISA = qw(VmRelocateSpecEvent);

our @property_list = (
   ['sourceHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmRelocatedEvent', 'sourceHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRelocateFailedEvent;
our @ISA = qw(VmRelocateSpecEvent);

our @property_list = (
   ['destHost', 'HostEventArgument', undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmRelocateFailedEvent', 'destHost', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmEmigratingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmEmigratingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmCloneEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmCloneEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmBeingClonedEvent;
our @ISA = qw(VmCloneEvent);

our @property_list = (
   ['destFolder', 'FolderEventArgument', undef, 1],
   ['destName', undef, undef, 1],
   ['destHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmBeingClonedEvent', 'destFolder', 'destName', 'destHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmCloneFailedEvent;
our @ISA = qw(VmCloneEvent);

our @property_list = (
   ['destFolder', 'FolderEventArgument', undef, 1],
   ['destName', undef, undef, 1],
   ['destHost', 'HostEventArgument', undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmCloneFailedEvent', 'destFolder', 'destName', 'destHost', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmClonedEvent;
our @ISA = qw(VmCloneEvent);

our @property_list = (
   ['sourceVm', 'VmEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmClonedEvent', 'sourceVm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmResourceReallocatedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmResourceReallocatedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRenamedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['oldName', undef, undef, 1],
   ['newName', undef, undef, 1],
);


VIMRuntime::make_get_set('VmRenamedEvent', 'oldName', 'newName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDateRolledBackEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmDateRolledBackEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmNoNetworkAccessEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['destHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmNoNetworkAccessEvent', 'destHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDiskFailedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['disk', undef, undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmDiskFailedEvent', 'disk', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToPowerOnEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToPowerOnEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToPowerOffEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToPowerOffEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToSuspendEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToSuspendEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToResetEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToResetEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToShutdownGuestEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToShutdownGuestEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToRebootGuestEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToRebootGuestEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedToStandbyGuestEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedToStandbyGuestEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRemovedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmRemovedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmGuestShutdownEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmGuestShutdownEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmGuestRebootEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmGuestRebootEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmGuestStandbyEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmGuestStandbyEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUpgradingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['version', undef, undef, 1],
);


VIMRuntime::make_get_set('VmUpgradingEvent', 'version');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUpgradeCompleteEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['version', undef, undef, 1],
);


VIMRuntime::make_get_set('VmUpgradeCompleteEvent', 'version');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUpgradeFailedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmUpgradeFailedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRestartedOnAlternateHostEvent;
our @ISA = qw(VmPoweredOnEvent);

our @property_list = (
   ['sourceHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmRestartedOnAlternateHostEvent', 'sourceHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmReconfiguredEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['configSpec', 'VirtualMachineConfigSpec', undef, 1],
);


VIMRuntime::make_get_set('VmReconfiguredEvent', 'configSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmMessageEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['message', undef, undef, 1],
);


VIMRuntime::make_get_set('VmMessageEvent', 'message');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConfigMissingEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmConfigMissingEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmPowerOffOnIsolationEvent;
our @ISA = qw(VmPoweredOffEvent);

our @property_list = (
   ['isolatedHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmPowerOffOnIsolationEvent', 'isolatedHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailoverFailed;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmFailoverFailed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotEnoughResourcesToStartVmEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('NotEnoughResourcesToStartVmEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUuidAssignedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['uuid', undef, undef, 1],
);


VIMRuntime::make_get_set('VmUuidAssignedEvent', 'uuid');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmUuidChangedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['oldUuid', undef, undef, 1],
   ['newUuid', undef, undef, 1],
);


VIMRuntime::make_get_set('VmUuidChangedEvent', 'oldUuid', 'newUuid');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedRelayoutOnVmfs2DatastoreEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmFailedRelayoutOnVmfs2DatastoreEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmFailedRelayoutEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('VmFailedRelayoutEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRelayoutSuccessfulEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmRelayoutSuccessfulEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmRelayoutUpToDateEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmRelayoutUpToDateEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConnectedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmConnectedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDasUpdateErrorEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmDasUpdateErrorEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoMaintenanceModeDrsRecommendationForVM;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('NoMaintenanceModeDrsRecommendationForVM');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDasUpdateOkEvent;
our @ISA = qw(VmEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VmDasUpdateOkEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskEvent;
our @ISA = qw(Event);

our @property_list = (
   ['scheduledTask', 'ScheduledTaskEventArgument', undef, 1],
   ['entity', 'ManagedEntityEventArgument', undef, 1],
);


VIMRuntime::make_get_set('ScheduledTaskEvent', 'scheduledTask', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskCreatedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ScheduledTaskCreatedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskStartedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ScheduledTaskStartedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskRemovedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ScheduledTaskRemovedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskReconfiguredEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ScheduledTaskReconfiguredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskCompletedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ScheduledTaskCompletedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskFailedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('ScheduledTaskFailedEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskEmailCompletedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
   ['to', undef, undef, 1],
);


VIMRuntime::make_get_set('ScheduledTaskEmailCompletedEvent', 'to');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskEmailFailedEvent;
our @ISA = qw(ScheduledTaskEvent);

our @property_list = (
   ['to', undef, undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('ScheduledTaskEmailFailedEvent', 'to', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmEvent;
our @ISA = qw(Event);

our @property_list = (
   ['alarm', 'AlarmEventArgument', undef, 1],
);


VIMRuntime::make_get_set('AlarmEvent', 'alarm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmCreatedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
);


VIMRuntime::make_get_set('AlarmCreatedEvent', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmStatusChangedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['source', 'ManagedEntityEventArgument', undef, 1],
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['from', undef, undef, 1],
   ['to', undef, undef, 1],
);


VIMRuntime::make_get_set('AlarmStatusChangedEvent', 'source', 'entity', 'from', 'to');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmActionTriggeredEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['source', 'ManagedEntityEventArgument', undef, 1],
   ['entity', 'ManagedEntityEventArgument', undef, 1],
);


VIMRuntime::make_get_set('AlarmActionTriggeredEvent', 'source', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmEmailCompletedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['to', undef, undef, 1],
);


VIMRuntime::make_get_set('AlarmEmailCompletedEvent', 'entity', 'to');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmEmailFailedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['to', undef, undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('AlarmEmailFailedEvent', 'entity', 'to', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmSnmpCompletedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
);


VIMRuntime::make_get_set('AlarmSnmpCompletedEvent', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmSnmpFailedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('AlarmSnmpFailedEvent', 'entity', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmScriptCompleteEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['script', undef, undef, 1],
);


VIMRuntime::make_get_set('AlarmScriptCompleteEvent', 'entity', 'script');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmScriptFailedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['script', undef, undef, 1],
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('AlarmScriptFailedEvent', 'entity', 'script', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmRemovedEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
);


VIMRuntime::make_get_set('AlarmRemovedEvent', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmReconfiguredEvent;
our @ISA = qw(AlarmEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
);


VIMRuntime::make_get_set('AlarmReconfiguredEvent', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldEvent;
our @ISA = qw(Event);

our @property_list = (
);


VIMRuntime::make_get_set('CustomFieldEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldDefEvent;
our @ISA = qw(CustomFieldEvent);

our @property_list = (
   ['fieldKey', undef, undef, 1],
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomFieldDefEvent', 'fieldKey', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldDefAddedEvent;
our @ISA = qw(CustomFieldDefEvent);

our @property_list = (
);


VIMRuntime::make_get_set('CustomFieldDefAddedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldDefRemovedEvent;
our @ISA = qw(CustomFieldDefEvent);

our @property_list = (
);


VIMRuntime::make_get_set('CustomFieldDefRemovedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldDefRenamedEvent;
our @ISA = qw(CustomFieldDefEvent);

our @property_list = (
   ['newName', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomFieldDefRenamedEvent', 'newName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomFieldValueChangedEvent;
our @ISA = qw(CustomFieldEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['fieldKey', undef, undef, 1],
   ['name', undef, undef, 1],
   ['value', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomFieldValueChangedEvent', 'entity', 'fieldKey', 'name', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AuthorizationEvent;
our @ISA = qw(Event);

our @property_list = (
);


VIMRuntime::make_get_set('AuthorizationEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PermissionEvent;
our @ISA = qw(AuthorizationEvent);

our @property_list = (
   ['entity', 'ManagedEntityEventArgument', undef, 1],
   ['principal', undef, undef, 1],
   ['group', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('PermissionEvent', 'entity', 'principal', 'group');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PermissionAddedEvent;
our @ISA = qw(PermissionEvent);

our @property_list = (
   ['role', 'RoleEventArgument', undef, 1],
   ['propagate', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('PermissionAddedEvent', 'role', 'propagate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PermissionUpdatedEvent;
our @ISA = qw(PermissionEvent);

our @property_list = (
   ['role', 'RoleEventArgument', undef, 1],
   ['propagate', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('PermissionUpdatedEvent', 'role', 'propagate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PermissionRemovedEvent;
our @ISA = qw(PermissionEvent);

our @property_list = (
);


VIMRuntime::make_get_set('PermissionRemovedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RoleEvent;
our @ISA = qw(AuthorizationEvent);

our @property_list = (
   ['role', 'RoleEventArgument', undef, 1],
);


VIMRuntime::make_get_set('RoleEvent', 'role');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RoleAddedEvent;
our @ISA = qw(RoleEvent);

our @property_list = (
   ['privilegeList', undef, 1, 0],
);


VIMRuntime::make_get_set('RoleAddedEvent', 'privilegeList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RoleUpdatedEvent;
our @ISA = qw(RoleEvent);

our @property_list = (
   ['privilegeList', undef, 1, 0],
);


VIMRuntime::make_get_set('RoleUpdatedEvent', 'privilegeList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RoleRemovedEvent;
our @ISA = qw(RoleEvent);

our @property_list = (
);


VIMRuntime::make_get_set('RoleRemovedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreEvent;
our @ISA = qw(Event);

our @property_list = (
   ['datastore', 'DatastoreEventArgument', undef, 0],
);


VIMRuntime::make_get_set('DatastoreEvent', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreDestroyedEvent;
our @ISA = qw(DatastoreEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DatastoreDestroyedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreRenamedEvent;
our @ISA = qw(DatastoreEvent);

our @property_list = (
   ['oldName', undef, undef, 1],
   ['newName', undef, undef, 1],
);


VIMRuntime::make_get_set('DatastoreRenamedEvent', 'oldName', 'newName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreDuplicatedEvent;
our @ISA = qw(DatastoreEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DatastoreDuplicatedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskEvent;
our @ISA = qw(Event);

our @property_list = (
   ['info', 'TaskInfo', undef, 1],
);


VIMRuntime::make_get_set('TaskEvent', 'info');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseEvent;
our @ISA = qw(Event);

our @property_list = (
);


VIMRuntime::make_get_set('LicenseEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ServerLicenseExpiredEvent;
our @ISA = qw(LicenseEvent);

our @property_list = (
   ['product', undef, undef, 1],
);


VIMRuntime::make_get_set('ServerLicenseExpiredEvent', 'product');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostLicenseExpiredEvent;
our @ISA = qw(LicenseEvent);

our @property_list = (
);


VIMRuntime::make_get_set('HostLicenseExpiredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionLicenseExpiredEvent;
our @ISA = qw(LicenseEvent);

our @property_list = (
);


VIMRuntime::make_get_set('VMotionLicenseExpiredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoLicenseEvent;
our @ISA = qw(LicenseEvent);

our @property_list = (
   ['feature', 'LicenseFeatureInfo', undef, 1],
);


VIMRuntime::make_get_set('NoLicenseEvent', 'feature');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseServerUnavailableEvent;
our @ISA = qw(LicenseEvent);

our @property_list = (
   ['licenseServer', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseServerUnavailableEvent', 'licenseServer');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseServerAvailableEvent;
our @ISA = qw(LicenseEvent);

our @property_list = (
   ['licenseServer', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseServerAvailableEvent', 'licenseServer');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseExpiredEvent;
our @ISA = qw(Event);

our @property_list = (
   ['feature', 'LicenseFeatureInfo', undef, 1],
);


VIMRuntime::make_get_set('LicenseExpiredEvent', 'feature');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['fault', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('MigrationEvent', 'fault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationWarningEvent;
our @ISA = qw(MigrationEvent);

our @property_list = (
);


VIMRuntime::make_get_set('MigrationWarningEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationErrorEvent;
our @ISA = qw(MigrationEvent);

our @property_list = (
);


VIMRuntime::make_get_set('MigrationErrorEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationHostWarningEvent;
our @ISA = qw(MigrationEvent);

our @property_list = (
   ['dstHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('MigrationHostWarningEvent', 'dstHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationHostErrorEvent;
our @ISA = qw(MigrationEvent);

our @property_list = (
   ['dstHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('MigrationHostErrorEvent', 'dstHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationResourceWarningEvent;
our @ISA = qw(MigrationEvent);

our @property_list = (
   ['dstPool', 'ResourcePoolEventArgument', undef, 1],
   ['dstHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('MigrationResourceWarningEvent', 'dstPool', 'dstHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationResourceErrorEvent;
our @ISA = qw(MigrationEvent);

our @property_list = (
   ['dstPool', 'ResourcePoolEventArgument', undef, 1],
   ['dstHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('MigrationResourceErrorEvent', 'dstPool', 'dstHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterEvent;
our @ISA = qw(Event);

our @property_list = (
);


VIMRuntime::make_get_set('ClusterEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasEnabledEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DasEnabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasDisabledEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DasDisabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasAdmissionControlDisabledEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DasAdmissionControlDisabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasAdmissionControlEnabledEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DasAdmissionControlEnabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasHostFailedEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
   ['failedHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('DasHostFailedEvent', 'failedHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasHostIsolatedEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
   ['isolatedHost', 'HostEventArgument', undef, 1],
);


VIMRuntime::make_get_set('DasHostIsolatedEvent', 'isolatedHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasAgentUnavailableEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DasAgentUnavailableEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasAgentFoundEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DasAgentFoundEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InsufficientFailoverResourcesEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('InsufficientFailoverResourcesEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FailoverLevelRestored;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('FailoverLevelRestored');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterOvercommittedEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ClusterOvercommittedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterStatusChangedEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
   ['oldStatus', undef, undef, 1],
   ['newStatus', undef, undef, 1],
);


VIMRuntime::make_get_set('ClusterStatusChangedEvent', 'oldStatus', 'newStatus');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterCreatedEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
   ['parent', 'FolderEventArgument', undef, 1],
);


VIMRuntime::make_get_set('ClusterCreatedEvent', 'parent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterDestroyedEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ClusterDestroyedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DrsEnabledEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
   ['behavior', undef, undef, 1],
);


VIMRuntime::make_get_set('DrsEnabledEvent', 'behavior');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DrsDisabledEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('DrsDisabledEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ClusterReconfiguredEvent;
our @ISA = qw(ClusterEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ClusterReconfiguredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolEvent;
our @ISA = qw(Event);

our @property_list = (
   ['resourcePool', 'ResourcePoolEventArgument', undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolEvent', 'resourcePool');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolCreatedEvent;
our @ISA = qw(ResourcePoolEvent);

our @property_list = (
   ['parent', 'ResourcePoolEventArgument', undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolCreatedEvent', 'parent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolDestroyedEvent;
our @ISA = qw(ResourcePoolEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ResourcePoolDestroyedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolMovedEvent;
our @ISA = qw(ResourcePoolEvent);

our @property_list = (
   ['oldParent', 'ResourcePoolEventArgument', undef, 1],
   ['newParent', 'ResourcePoolEventArgument', undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolMovedEvent', 'oldParent', 'newParent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolReconfiguredEvent;
our @ISA = qw(ResourcePoolEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ResourcePoolReconfiguredEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourceViolatedEvent;
our @ISA = qw(ResourcePoolEvent);

our @property_list = (
);


VIMRuntime::make_get_set('ResourceViolatedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmResourcePoolMovedEvent;
our @ISA = qw(VmEvent);

our @property_list = (
   ['oldParent', 'ResourcePoolEventArgument', undef, 1],
   ['newParent', 'ResourcePoolEventArgument', undef, 1],
);


VIMRuntime::make_get_set('VmResourcePoolMovedEvent', 'oldParent', 'newParent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TemplateUpgradeEvent;
our @ISA = qw(Event);

our @property_list = (
   ['legacyTemplate', undef, undef, 1],
);


VIMRuntime::make_get_set('TemplateUpgradeEvent', 'legacyTemplate');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TemplateBeingUpgradedEvent;
our @ISA = qw(TemplateUpgradeEvent);

our @property_list = (
);


VIMRuntime::make_get_set('TemplateBeingUpgradedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TemplateUpgradeFailedEvent;
our @ISA = qw(TemplateUpgradeEvent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('TemplateUpgradeFailedEvent', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TemplateUpgradedEvent;
our @ISA = qw(TemplateUpgradeEvent);

our @property_list = (
);


VIMRuntime::make_get_set('TemplateUpgradedEvent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventArgument;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('EventArgument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RoleEventArgument;
our @ISA = qw(EventArgument);

our @property_list = (
   ['roleId', undef, undef, 1],
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('RoleEventArgument', 'roleId', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EntityEventArgument;
our @ISA = qw(EventArgument);

our @property_list = (
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('EntityEventArgument', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ManagedEntityEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('ManagedEntityEventArgument', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FolderEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['folder', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('FolderEventArgument', 'folder');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatacenterEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['datacenter', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('DatacenterEventArgument', 'datacenter');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ComputeResourceEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['computeResource', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('ComputeResourceEventArgument', 'computeResource');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourcePoolEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['resourcePool', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('ResourcePoolEventArgument', 'resourcePool');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('HostEventArgument', 'host');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['vm', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('VmEventArgument', 'vm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['datastore', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('DatastoreEventArgument', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlarmEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['alarm', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('AlarmEventArgument', 'alarm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskEventArgument;
our @ISA = qw(EntityEventArgument);

our @property_list = (
   ['scheduledTask', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('ScheduledTaskEventArgument', 'scheduledTask');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventDescriptionEventDetail;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['category', undef, undef, 1],
   ['formatOnDatacenter', undef, undef, 1],
   ['formatOnComputeResource', undef, undef, 1],
   ['formatOnHost', undef, undef, 1],
   ['formatOnVm', undef, undef, 1],
   ['fullFormat', undef, undef, 1],
);


VIMRuntime::make_get_set('EventDescriptionEventDetail', 'key', 'category', 'formatOnDatacenter', 'formatOnComputeResource', 'formatOnHost', 'formatOnVm', 'fullFormat');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfEventDescriptionEventDetail;
our @ISA = qw(ComplexType);

our @property_list = (
   ['EventDescriptionEventDetail', 'EventDescriptionEventDetail', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfEventDescriptionEventDetail', 'EventDescriptionEventDetail');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['category', 'ElementDescription', 1, 1],
   ['eventInfo', 'EventDescriptionEventDetail', 1, 1],
);


VIMRuntime::make_get_set('EventDescription', 'category', 'eventInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventFilterSpecByEntity;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
   ['recursion', 'EventFilterSpecRecursionOption', undef, 1],
);


VIMRuntime::make_get_set('EventFilterSpecByEntity', 'entity', 'recursion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventFilterSpecByTime;
our @ISA = qw(DynamicData);

our @property_list = (
   ['beginTime', undef, undef, 0],
   ['endTime', undef, undef, 0],
);


VIMRuntime::make_get_set('EventFilterSpecByTime', 'beginTime', 'endTime');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventFilterSpecByUsername;
our @ISA = qw(DynamicData);

our @property_list = (
   ['systemUser', 'boolean', undef, 1],
   ['userList', undef, 1, 0],
);


VIMRuntime::make_get_set('EventFilterSpecByUsername', 'systemUser', 'userList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package EventFilterSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'EventFilterSpecByEntity', undef, 0],
   ['time', 'EventFilterSpecByTime', undef, 0],
   ['userName', 'EventFilterSpecByUsername', undef, 0],
   ['eventChainId', undef, undef, 0],
   ['alarm', 'ManagedObjectReference', undef, 0],
   ['scheduledTask', 'ManagedObjectReference', undef, 0],
   ['disableFullMessage', 'boolean', undef, 0],
   ['category', undef, 1, 0],
   ['type', undef, 1, 0],
);


VIMRuntime::make_get_set('EventFilterSpec', 'entity', 'time', 'userName', 'eventChainId', 'alarm', 'scheduledTask', 'disableFullMessage', 'category', 'type');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AffinityConfigured;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['configuredAffinity', undef, 1, 1],
);


VIMRuntime::make_get_set('AffinityConfigured', 'configuredAffinity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AgentInstallFailed;
our @ISA = qw(HostConnectFault);

our @property_list = (
);


VIMRuntime::make_get_set('AgentInstallFailed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlreadyBeingManaged;
our @ISA = qw(HostConnectFault);

our @property_list = (
   ['ipAddress', undef, undef, 1],
);


VIMRuntime::make_get_set('AlreadyBeingManaged', 'ipAddress');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlreadyConnected;
our @ISA = qw(HostConnectFault);

our @property_list = (
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('AlreadyConnected', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlreadyExists;
our @ISA = qw(VimFault);

our @property_list = (
   ['name', undef, undef, 0],
);


VIMRuntime::make_get_set('AlreadyExists', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AlreadyUpgraded;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('AlreadyUpgraded');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ApplicationQuiesceFault;
our @ISA = qw(SnapshotFault);

our @property_list = (
);


VIMRuntime::make_get_set('ApplicationQuiesceFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AuthMinimumAdminPermission;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('AuthMinimumAdminPermission');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessFile;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('CannotAccessFile');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessLocalSource;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('CannotAccessLocalSource');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessNetwork;
our @ISA = qw(CannotAccessVmDevice);

our @property_list = (
);


VIMRuntime::make_get_set('CannotAccessNetwork');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessVmComponent;
our @ISA = qw(VmConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('CannotAccessVmComponent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessVmConfig;
our @ISA = qw(CannotAccessVmComponent);

our @property_list = (
   ['reason', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('CannotAccessVmConfig', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessVmDevice;
our @ISA = qw(CannotAccessVmComponent);

our @property_list = (
   ['device', undef, undef, 1],
   ['backing', undef, undef, 1],
   ['connected', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('CannotAccessVmDevice', 'device', 'backing', 'connected');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotAccessVmDisk;
our @ISA = qw(CannotAccessVmDevice);

our @property_list = (
   ['fault', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('CannotAccessVmDisk', 'fault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotDecryptPasswords;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('CannotDecryptPasswords');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotDeleteFile;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('CannotDeleteFile');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CannotModifyConfigCpuRequirements;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('CannotModifyConfigCpuRequirements');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ConcurrentAccess;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('ConcurrentAccess');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CpuCompatibilityUnknown;
our @ISA = qw(CpuIncompatible);

our @property_list = (
);


VIMRuntime::make_get_set('CpuCompatibilityUnknown');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CpuIncompatible;
our @ISA = qw(VirtualHardwareCompatibilityIssue);

our @property_list = (
   ['level', undef, undef, 1],
   ['registerName', undef, undef, 1],
);


VIMRuntime::make_get_set('CpuIncompatible', 'level', 'registerName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DasConfigFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('DasConfigFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatabaseError;
our @ISA = qw(RuntimeFault);

our @property_list = (
);


VIMRuntime::make_get_set('DatabaseError');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatacenterMismatchArgument;
our @ISA = qw(DynamicData);

our @property_list = (
   ['entity', 'ManagedObjectReference', undef, 1],
   ['inputDatacenter', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('DatacenterMismatchArgument', 'entity', 'inputDatacenter');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfDatacenterMismatchArgument;
our @ISA = qw(ComplexType);

our @property_list = (
   ['DatacenterMismatchArgument', 'DatacenterMismatchArgument', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfDatacenterMismatchArgument', 'DatacenterMismatchArgument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatacenterMismatch;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['invalidArgument', 'DatacenterMismatchArgument', 1, 1],
   ['expectedDatacenter', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('DatacenterMismatch', 'invalidArgument', 'expectedDatacenter');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreNotWritableOnHost;
our @ISA = qw(InvalidDatastore);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('DatastoreNotWritableOnHost', 'host');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DestinationSwitchFull;
our @ISA = qw(CannotAccessNetwork);

our @property_list = (
);


VIMRuntime::make_get_set('DestinationSwitchFull');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DeviceNotFound;
our @ISA = qw(InvalidDeviceSpec);

our @property_list = (
);


VIMRuntime::make_get_set('DeviceNotFound');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DeviceNotSupported;
our @ISA = qw(VirtualHardwareCompatibilityIssue);

our @property_list = (
   ['device', undef, undef, 1],
);


VIMRuntime::make_get_set('DeviceNotSupported', 'device');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DisallowedDiskModeChange;
our @ISA = qw(InvalidDeviceSpec);

our @property_list = (
);


VIMRuntime::make_get_set('DisallowedDiskModeChange');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DisallowedMigrationDeviceAttached;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['fault', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('DisallowedMigrationDeviceAttached', 'fault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DiskNotSupported;
our @ISA = qw(VirtualHardwareCompatibilityIssue);

our @property_list = (
   ['disk', undef, undef, 1],
);


VIMRuntime::make_get_set('DiskNotSupported', 'disk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DuplicateName;
our @ISA = qw(VimFault);

our @property_list = (
   ['name', undef, undef, 1],
   ['object', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('DuplicateName', 'name', 'object');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileAlreadyExists;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('FileAlreadyExists');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileFault;
our @ISA = qw(VimFault);

our @property_list = (
   ['file', undef, undef, 1],
);


VIMRuntime::make_get_set('FileFault', 'file');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileLocked;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('FileLocked');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileNotFound;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('FileNotFound');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileNotWritable;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('FileNotWritable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FilesystemQuiesceFault;
our @ISA = qw(SnapshotFault);

our @property_list = (
);


VIMRuntime::make_get_set('FilesystemQuiesceFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GenericVmConfigFault;
our @ISA = qw(VmConfigFault);

our @property_list = (
   ['reason', undef, undef, 1],
);


VIMRuntime::make_get_set('GenericVmConfigFault', 'reason');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConfigFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('HostConfigFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConnectFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('HostConnectFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IDEDiskNotSupported;
our @ISA = qw(DiskNotSupported);

our @property_list = (
);


VIMRuntime::make_get_set('IDEDiskNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InaccessibleDatastore;
our @ISA = qw(InvalidDatastore);

our @property_list = (
);


VIMRuntime::make_get_set('InaccessibleDatastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IncompatibleSetting;
our @ISA = qw(InvalidArgument);

our @property_list = (
   ['conflictingProperty', undef, undef, 1],
);


VIMRuntime::make_get_set('IncompatibleSetting', 'conflictingProperty');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IncorrectFileType;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('IncorrectFileType');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InsufficientCpuResourcesFault;
our @ISA = qw(InsufficientResourcesFault);

our @property_list = (
   ['unreserved', undef, undef, 1],
   ['requested', undef, undef, 1],
);


VIMRuntime::make_get_set('InsufficientCpuResourcesFault', 'unreserved', 'requested');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InsufficientFailoverResourcesFault;
our @ISA = qw(InsufficientResourcesFault);

our @property_list = (
);


VIMRuntime::make_get_set('InsufficientFailoverResourcesFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InsufficientHostCapacityFault;
our @ISA = qw(InsufficientResourcesFault);

our @property_list = (
);


VIMRuntime::make_get_set('InsufficientHostCapacityFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InsufficientMemoryResourcesFault;
our @ISA = qw(InsufficientResourcesFault);

our @property_list = (
   ['unreserved', undef, undef, 1],
   ['requested', undef, undef, 1],
);


VIMRuntime::make_get_set('InsufficientMemoryResourcesFault', 'unreserved', 'requested');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InsufficientResourcesFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('InsufficientResourcesFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidController;
our @ISA = qw(InvalidDeviceSpec);

our @property_list = (
   ['controllerKey', undef, undef, 1],
);


VIMRuntime::make_get_set('InvalidController', 'controllerKey');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidDatastore;
our @ISA = qw(VimFault);

our @property_list = (
   ['datastore', 'ManagedObjectReference', undef, 0],
   ['name', undef, undef, 0],
);


VIMRuntime::make_get_set('InvalidDatastore', 'datastore', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidDatastorePath;
our @ISA = qw(InvalidDatastore);

our @property_list = (
   ['datastorePath', undef, undef, 1],
);


VIMRuntime::make_get_set('InvalidDatastorePath', 'datastorePath');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidDeviceBacking;
our @ISA = qw(InvalidDeviceSpec);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidDeviceBacking');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidDeviceOperation;
our @ISA = qw(InvalidDeviceSpec);

our @property_list = (
   ['badOp', 'VirtualDeviceConfigSpecOperation', undef, 0],
   ['badFileOp', 'VirtualDeviceConfigSpecFileOperation', undef, 0],
);


VIMRuntime::make_get_set('InvalidDeviceOperation', 'badOp', 'badFileOp');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidDeviceSpec;
our @ISA = qw(InvalidVmConfig);

our @property_list = (
   ['deviceIndex', undef, undef, 1],
);


VIMRuntime::make_get_set('InvalidDeviceSpec', 'deviceIndex');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidDiskFormat;
our @ISA = qw(InvalidFormat);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidDiskFormat');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidFolder;
our @ISA = qw(VimFault);

our @property_list = (
   ['target', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('InvalidFolder', 'target');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidFormat;
our @ISA = qw(VmConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidFormat');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidLicense;
our @ISA = qw(VimFault);

our @property_list = (
   ['licenseContent', undef, undef, 1],
);


VIMRuntime::make_get_set('InvalidLicense', 'licenseContent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidLocale;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidLocale');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidLogin;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidLogin');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidName;
our @ISA = qw(VimFault);

our @property_list = (
   ['name', undef, undef, 1],
   ['entity', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('InvalidName', 'name', 'entity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidPowerState;
our @ISA = qw(InvalidState);

our @property_list = (
   ['requestedState', 'VirtualMachinePowerState', undef, 0],
   ['existingState', 'VirtualMachinePowerState', undef, 1],
);


VIMRuntime::make_get_set('InvalidPowerState', 'requestedState', 'existingState');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidResourcePoolStructureFault;
our @ISA = qw(InsufficientResourcesFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidResourcePoolStructureFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidSnapshotFormat;
our @ISA = qw(InvalidFormat);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidSnapshotFormat');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidState;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('InvalidState');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package InvalidVmConfig;
our @ISA = qw(VmConfigFault);

our @property_list = (
   ['property', undef, undef, 0],
);


VIMRuntime::make_get_set('InvalidVmConfig', 'property');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IpHostnameGeneratorError;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('IpHostnameGeneratorError');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LegacyNetworkInterfaceInUse;
our @ISA = qw(CannotAccessNetwork);

our @property_list = (
);


VIMRuntime::make_get_set('LegacyNetworkInterfaceInUse');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LicenseServerUnavailable;
our @ISA = qw(VimFault);

our @property_list = (
   ['licenseServer', undef, undef, 1],
);


VIMRuntime::make_get_set('LicenseServerUnavailable', 'licenseServer');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LinuxVolumeNotClean;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('LinuxVolumeNotClean');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LogBundlingFailed;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('LogBundlingFailed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MemorySnapshotOnIndependentDisk;
our @ISA = qw(SnapshotFault);

our @property_list = (
);


VIMRuntime::make_get_set('MemorySnapshotOnIndependentDisk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MigrationFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('MigrationFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MismatchedNetworkPolicies;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['device', undef, undef, 1],
   ['backing', undef, undef, 1],
   ['connected', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('MismatchedNetworkPolicies', 'device', 'backing', 'connected');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MismatchedVMotionNetworkNames;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['sourceNetwork', undef, undef, 1],
   ['destNetwork', undef, undef, 1],
);


VIMRuntime::make_get_set('MismatchedVMotionNetworkNames', 'sourceNetwork', 'destNetwork');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MissingController;
our @ISA = qw(InvalidDeviceSpec);

our @property_list = (
);


VIMRuntime::make_get_set('MissingController');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MissingLinuxCustResources;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('MissingLinuxCustResources');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MissingWindowsCustResources;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('MissingWindowsCustResources');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MountError;
our @ISA = qw(CustomizationFault);

our @property_list = (
   ['vm', 'ManagedObjectReference', undef, 1],
   ['diskIndex', undef, undef, 1],
);


VIMRuntime::make_get_set('MountError', 'vm', 'diskIndex');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MultipleSnapshotsNotSupported;
our @ISA = qw(SnapshotFault);

our @property_list = (
);


VIMRuntime::make_get_set('MultipleSnapshotsNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NetworkCopyFault;
our @ISA = qw(FileFault);

our @property_list = (
);


VIMRuntime::make_get_set('NetworkCopyFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoActiveHostInCluster;
our @ISA = qw(InvalidState);

our @property_list = (
   ['computeResource', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('NoActiveHostInCluster', 'computeResource');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoDiskFound;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('NoDiskFound');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoDiskSpace;
our @ISA = qw(FileFault);

our @property_list = (
   ['datastore', undef, undef, 1],
);


VIMRuntime::make_get_set('NoDiskSpace', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoDisksToCustomize;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('NoDisksToCustomize');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoGateway;
our @ISA = qw(HostConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('NoGateway');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoGuestHeartbeat;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('NoGuestHeartbeat');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoHost;
our @ISA = qw(HostConnectFault);

our @property_list = (
   ['name', undef, undef, 0],
);


VIMRuntime::make_get_set('NoHost', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoPermission;
our @ISA = qw(SecurityError);

our @property_list = (
   ['object', 'ManagedObjectReference', undef, 1],
   ['privilegeId', undef, undef, 1],
);


VIMRuntime::make_get_set('NoPermission', 'object', 'privilegeId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoPermissionOnHost;
our @ISA = qw(HostConnectFault);

our @property_list = (
);


VIMRuntime::make_get_set('NoPermissionOnHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NoVirtualNic;
our @ISA = qw(HostConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('NoVirtualNic');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotEnoughCpus;
our @ISA = qw(VirtualHardwareCompatibilityIssue);

our @property_list = (
   ['numCpuDest', undef, undef, 1],
   ['numCpuVm', undef, undef, 1],
);


VIMRuntime::make_get_set('NotEnoughCpus', 'numCpuDest', 'numCpuVm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotEnoughLogicalCpus;
our @ISA = qw(NotEnoughCpus);

our @property_list = (
);


VIMRuntime::make_get_set('NotEnoughLogicalCpus');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotFound;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('NotFound');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NotSupportedHost;
our @ISA = qw(HostConnectFault);

our @property_list = (
   ['productName', undef, undef, 0],
   ['productVersion', undef, undef, 0],
);


VIMRuntime::make_get_set('NotSupportedHost', 'productName', 'productVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NumVirtualCpusNotSupported;
our @ISA = qw(VirtualHardwareCompatibilityIssue);

our @property_list = (
   ['maxSupportedVcpusDest', undef, undef, 1],
   ['numCpuVm', undef, undef, 1],
);


VIMRuntime::make_get_set('NumVirtualCpusNotSupported', 'maxSupportedVcpusDest', 'numCpuVm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package OutOfBounds;
our @ISA = qw(VimFault);

our @property_list = (
   ['argumentName', undef, undef, 1],
);


VIMRuntime::make_get_set('OutOfBounds', 'argumentName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysCompatRDMNotSupported;
our @ISA = qw(RDMNotSupported);

our @property_list = (
);


VIMRuntime::make_get_set('PhysCompatRDMNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PlatformConfigFault;
our @ISA = qw(HostConfigFault);

our @property_list = (
   ['text', undef, undef, 1],
);


VIMRuntime::make_get_set('PlatformConfigFault', 'text');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RDMNotPreserved;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['device', undef, undef, 1],
);


VIMRuntime::make_get_set('RDMNotPreserved', 'device');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RDMNotSupported;
our @ISA = qw(DeviceNotSupported);

our @property_list = (
);


VIMRuntime::make_get_set('RDMNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RDMPointsToInaccessibleDisk;
our @ISA = qw(CannotAccessVmDisk);

our @property_list = (
);


VIMRuntime::make_get_set('RDMPointsToInaccessibleDisk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RawDiskNotSupported;
our @ISA = qw(DeviceNotSupported);

our @property_list = (
);


VIMRuntime::make_get_set('RawDiskNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ReadOnlyDisksWithLegacyDestination;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['roDiskCount', undef, undef, 1],
   ['timeoutDanger', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('ReadOnlyDisksWithLegacyDestination', 'roDiskCount', 'timeoutDanger');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RemoteDeviceNotSupported;
our @ISA = qw(DeviceNotSupported);

our @property_list = (
);


VIMRuntime::make_get_set('RemoteDeviceNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RemoveFailed;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('RemoveFailed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ResourceInUse;
our @ISA = qw(VimFault);

our @property_list = (
   ['type', undef, undef, 0],
   ['name', undef, undef, 0],
);


VIMRuntime::make_get_set('ResourceInUse', 'type', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RuleViolation;
our @ISA = qw(VmConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('RuleViolation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SharedBusControllerNotSupported;
our @ISA = qw(DeviceNotSupported);

our @property_list = (
);


VIMRuntime::make_get_set('SharedBusControllerNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SnapshotCopyNotSupported;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('SnapshotCopyNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SnapshotFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('SnapshotFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SnapshotIncompatibleDeviceInVm;
our @ISA = qw(SnapshotFault);

our @property_list = (
   ['fault', 'LocalizedMethodFault', undef, 1],
);


VIMRuntime::make_get_set('SnapshotIncompatibleDeviceInVm', 'fault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SnapshotRevertIssue;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['snapshotName', undef, undef, 0],
   ['event', 'Event', 1, 0],
   ['errors', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('SnapshotRevertIssue', 'snapshotName', 'event', 'errors');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package SuspendedRelocateNotSupported;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('SuspendedRelocateNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskInProgress;
our @ISA = qw(VimFault);

our @property_list = (
   ['task', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('TaskInProgress', 'task');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package Timedout;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('Timedout');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TooManyDevices;
our @ISA = qw(InvalidVmConfig);

our @property_list = (
);


VIMRuntime::make_get_set('TooManyDevices');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TooManyHosts;
our @ISA = qw(HostConnectFault);

our @property_list = (
);


VIMRuntime::make_get_set('TooManyHosts');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TooManySnapshotLevels;
our @ISA = qw(SnapshotFault);

our @property_list = (
);


VIMRuntime::make_get_set('TooManySnapshotLevels');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ToolsUnavailable;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('ToolsUnavailable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UncommittedUndoableDisk;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('UncommittedUndoableDisk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UncustomizableGuest;
our @ISA = qw(CustomizationFault);

our @property_list = (
   ['uncustomizableGuestOS', undef, undef, 1],
);


VIMRuntime::make_get_set('UncustomizableGuest', 'uncustomizableGuestOS');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UnexpectedCustomizationFault;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('UnexpectedCustomizationFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UnsupportedDatastore;
our @ISA = qw(VmConfigFault);

our @property_list = (
   ['datastore', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('UnsupportedDatastore', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UnsupportedGuest;
our @ISA = qw(InvalidVmConfig);

our @property_list = (
   ['unsupportedGuestOS', undef, undef, 1],
);


VIMRuntime::make_get_set('UnsupportedGuest', 'unsupportedGuestOS');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UnsupportedVmxLocation;
our @ISA = qw(VmConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('UnsupportedVmxLocation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package UserNotFound;
our @ISA = qw(VimFault);

our @property_list = (
   ['principal', undef, undef, 1],
   ['unresolved', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('UserNotFound', 'principal', 'unresolved');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMOnVirtualIntranet;
our @ISA = qw(CannotAccessNetwork);

our @property_list = (
);


VIMRuntime::make_get_set('VMOnVirtualIntranet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionInterfaceIssue;
our @ISA = qw(MigrationFault);

our @property_list = (
   ['atSourceHost', 'boolean', undef, 1],
   ['failedHost', undef, undef, 1],
);


VIMRuntime::make_get_set('VMotionInterfaceIssue', 'atSourceHost', 'failedHost');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionLinkCapacityLow;
our @ISA = qw(VMotionInterfaceIssue);

our @property_list = (
   ['network', undef, undef, 1],
);


VIMRuntime::make_get_set('VMotionLinkCapacityLow', 'network');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionLinkDown;
our @ISA = qw(VMotionInterfaceIssue);

our @property_list = (
   ['network', undef, undef, 1],
);


VIMRuntime::make_get_set('VMotionLinkDown', 'network');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionNotConfigured;
our @ISA = qw(VMotionInterfaceIssue);

our @property_list = (
);


VIMRuntime::make_get_set('VMotionNotConfigured');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionNotLicensed;
our @ISA = qw(VMotionInterfaceIssue);

our @property_list = (
);


VIMRuntime::make_get_set('VMotionNotLicensed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionNotSupported;
our @ISA = qw(VMotionInterfaceIssue);

our @property_list = (
);


VIMRuntime::make_get_set('VMotionNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VMotionProtocolIncompatible;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('VMotionProtocolIncompatible');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VimFault;
our @ISA = qw(MethodFault);

our @property_list = (
);


VIMRuntime::make_get_set('VimFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualHardwareCompatibilityIssue;
our @ISA = qw(VmConfigFault);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualHardwareCompatibilityIssue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualHardwareVersionNotSupported;
our @ISA = qw(VirtualHardwareCompatibilityIssue);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualHardwareVersionNotSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConfigFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('VmConfigFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmLimitLicense;
our @ISA = qw(NotEnoughLicenses);

our @property_list = (
   ['limit', undef, undef, 1],
);


VIMRuntime::make_get_set('VmLimitLicense', 'limit');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmToolsUpgradeFault;
our @ISA = qw(VimFault);

our @property_list = (
);


VIMRuntime::make_get_set('VmToolsUpgradeFault');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VolumeEditorError;
our @ISA = qw(CustomizationFault);

our @property_list = (
);


VIMRuntime::make_get_set('VolumeEditorError');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package WillModifyConfigCpuRequirements;
our @ISA = qw(MigrationFault);

our @property_list = (
);


VIMRuntime::make_get_set('WillModifyConfigCpuRequirements');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AutoStartDefaults;
our @ISA = qw(DynamicData);

our @property_list = (
   ['enabled', 'boolean', undef, 0],
   ['startDelay', undef, undef, 0],
   ['stopDelay', undef, undef, 0],
   ['waitForHeartbeat', 'boolean', undef, 0],
   ['stopAction', undef, undef, 0],
);


VIMRuntime::make_get_set('AutoStartDefaults', 'enabled', 'startDelay', 'stopDelay', 'waitForHeartbeat', 'stopAction');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AutoStartPowerInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', 'ManagedObjectReference', undef, 1],
   ['startOrder', undef, undef, 1],
   ['startDelay', undef, undef, 1],
   ['waitForHeartbeat', 'AutoStartWaitHeartbeatSetting', undef, 1],
   ['startAction', undef, undef, 1],
   ['stopDelay', undef, undef, 1],
   ['stopAction', undef, undef, 1],
);


VIMRuntime::make_get_set('AutoStartPowerInfo', 'key', 'startOrder', 'startDelay', 'waitForHeartbeat', 'startAction', 'stopDelay', 'stopAction');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAutoStartPowerInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['AutoStartPowerInfo', 'AutoStartPowerInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAutoStartPowerInfo', 'AutoStartPowerInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostAutoStartManagerConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['defaults', 'AutoStartDefaults', undef, 0],
   ['powerInfo', 'AutoStartPowerInfo', 1, 0],
);


VIMRuntime::make_get_set('HostAutoStartManagerConfig', 'defaults', 'powerInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCapability;
our @ISA = qw(DynamicData);

our @property_list = (
   ['recursiveResourcePoolsSupported', 'boolean', undef, 1],
   ['rebootSupported', 'boolean', undef, 1],
   ['shutdownSupported', 'boolean', undef, 1],
   ['vmotionSupported', 'boolean', undef, 1],
   ['maxSupportedVMs', undef, undef, 0],
   ['maxRunningVMs', undef, undef, 0],
   ['maxSupportedVcpus', undef, undef, 0],
   ['datastorePrincipalSupported', 'boolean', undef, 1],
   ['sanSupported', 'boolean', undef, 1],
   ['nfsSupported', 'boolean', undef, 1],
   ['iscsiSupported', 'boolean', undef, 1],
   ['vlanTaggingSupported', 'boolean', undef, 1],
   ['nicTeamingSupported', 'boolean', undef, 1],
   ['highGuestMemSupported', 'boolean', undef, 1],
   ['maintenanceModeSupported', 'boolean', undef, 1],
   ['suspendedRelocateSupported', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostCapability', 'recursiveResourcePoolsSupported', 'rebootSupported', 'shutdownSupported', 'vmotionSupported', 'maxSupportedVMs', 'maxRunningVMs', 'maxSupportedVcpus', 'datastorePrincipalSupported', 'sanSupported', 'nfsSupported', 'iscsiSupported', 'vlanTaggingSupported', 'nicTeamingSupported', 'highGuestMemSupported', 'maintenanceModeSupported', 'suspendedRelocateSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConfigChange;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('HostConfigChange');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 1],
   ['product', 'AboutInfo', undef, 1],
   ['hyperThread', 'HostHyperThreadScheduleInfo', undef, 0],
   ['consoleReservation', 'ServiceConsoleReservationInfo', undef, 0],
   ['storageDevice', 'HostStorageDeviceInfo', undef, 0],
   ['fileSystemVolume', 'HostFileSystemVolumeInfo', undef, 0],
   ['network', 'HostNetworkInfo', undef, 0],
   ['vmotion', 'HostVMotionInfo', undef, 0],
   ['capabilities', 'HostNetCapabilities', undef, 0],
   ['offloadCapabilities', 'HostNetOffloadCapabilities', undef, 0],
   ['service', 'HostServiceInfo', undef, 0],
   ['firewall', 'HostFirewallInfo', undef, 0],
   ['autoStart', 'HostAutoStartManagerConfig', undef, 0],
   ['activeDiagnosticPartition', 'HostDiagnosticPartition', undef, 0],
   ['option', 'OptionValue', 1, 0],
   ['optionDef', 'OptionDef', 1, 0],
   ['datastorePrincipal', undef, undef, 0],
   ['systemResources', 'HostSystemResourceInfo', undef, 0],
);


VIMRuntime::make_get_set('HostConfigInfo', 'host', 'product', 'hyperThread', 'consoleReservation', 'storageDevice', 'fileSystemVolume', 'network', 'vmotion', 'capabilities', 'offloadCapabilities', 'service', 'firewall', 'autoStart', 'activeDiagnosticPartition', 'option', 'optionDef', 'datastorePrincipal', 'systemResources');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConfigManager;
our @ISA = qw(DynamicData);

our @property_list = (
   ['cpuScheduler', 'ManagedObjectReference', undef, 0],
   ['datastoreSystem', 'ManagedObjectReference', undef, 0],
   ['memoryManager', 'ManagedObjectReference', undef, 0],
   ['storageSystem', 'ManagedObjectReference', undef, 0],
   ['networkSystem', 'ManagedObjectReference', undef, 0],
   ['vmotionSystem', 'ManagedObjectReference', undef, 0],
   ['serviceSystem', 'ManagedObjectReference', undef, 0],
   ['firewallSystem', 'ManagedObjectReference', undef, 0],
   ['advancedOption', 'ManagedObjectReference', undef, 0],
   ['diagnosticSystem', 'ManagedObjectReference', undef, 0],
   ['autoStartManager', 'ManagedObjectReference', undef, 0],
   ['snmpSystem', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('HostConfigManager', 'cpuScheduler', 'datastoreSystem', 'memoryManager', 'storageSystem', 'networkSystem', 'vmotionSystem', 'serviceSystem', 'firewallSystem', 'advancedOption', 'diagnosticSystem', 'autoStartManager', 'snmpSystem');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConnectInfoNetworkInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['summary', 'NetworkSummary', undef, 1],
);


VIMRuntime::make_get_set('HostConnectInfoNetworkInfo', 'summary');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostConnectInfoNetworkInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostConnectInfoNetworkInfo', 'HostConnectInfoNetworkInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostConnectInfoNetworkInfo', 'HostConnectInfoNetworkInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNewNetworkConnectInfo;
our @ISA = qw(HostConnectInfoNetworkInfo);

our @property_list = (
);


VIMRuntime::make_get_set('HostNewNetworkConnectInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDatastoreConnectInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['summary', 'DatastoreSummary', undef, 1],
);


VIMRuntime::make_get_set('HostDatastoreConnectInfo', 'summary');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDatastoreConnectInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDatastoreConnectInfo', 'HostDatastoreConnectInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDatastoreConnectInfo', 'HostDatastoreConnectInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDatastoreExistsConnectInfo;
our @ISA = qw(HostDatastoreConnectInfo);

our @property_list = (
   ['newDatastoreName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDatastoreExistsConnectInfo', 'newDatastoreName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDatastoreNameConflictConnectInfo;
our @ISA = qw(HostDatastoreConnectInfo);

our @property_list = (
   ['newDatastoreName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDatastoreNameConflictConnectInfo', 'newDatastoreName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConnectInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['serverIp', undef, undef, 0],
   ['host', 'HostListSummary', undef, 1],
   ['vm', 'VirtualMachineSummary', 1, 0],
   ['vimAccountNameRequired', 'boolean', undef, 0],
   ['clusterSupported', 'boolean', undef, 0],
   ['network', 'HostConnectInfoNetworkInfo', 1, 0],
   ['datastore', 'HostDatastoreConnectInfo', 1, 0],
);


VIMRuntime::make_get_set('HostConnectInfo', 'serverIp', 'host', 'vm', 'vimAccountNameRequired', 'clusterSupported', 'network', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConnectSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['hostName', undef, undef, 0],
   ['port', undef, undef, 0],
   ['userName', undef, undef, 0],
   ['password', undef, undef, 0],
   ['vmFolder', 'ManagedObjectReference', undef, 0],
   ['force', 'boolean', undef, 1],
   ['vimAccountName', undef, undef, 0],
   ['vimAccountPassword', undef, undef, 0],
);


VIMRuntime::make_get_set('HostConnectSpec', 'hostName', 'port', 'userName', 'password', 'vmFolder', 'force', 'vimAccountName', 'vimAccountPassword');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCpuIdInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['level', undef, undef, 1],
   ['vendor', undef, undef, 0],
   ['eax', undef, undef, 0],
   ['ebx', undef, undef, 0],
   ['ecx', undef, undef, 0],
   ['edx', undef, undef, 0],
);


VIMRuntime::make_get_set('HostCpuIdInfo', 'level', 'vendor', 'eax', 'ebx', 'ecx', 'edx');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostCpuIdInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostCpuIdInfo', 'HostCpuIdInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostCpuIdInfo', 'HostCpuIdInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostHyperThreadScheduleInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['available', 'boolean', undef, 1],
   ['active', 'boolean', undef, 1],
   ['config', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostHyperThreadScheduleInfo', 'available', 'active', 'config');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileQueryFlags;
our @ISA = qw(DynamicData);

our @property_list = (
   ['fileType', 'boolean', undef, 1],
   ['fileSize', 'boolean', undef, 1],
   ['modification', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('FileQueryFlags', 'fileType', 'fileSize', 'modification');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['path', undef, undef, 1],
   ['fileSize', undef, undef, 0],
   ['modification', undef, undef, 0],
);


VIMRuntime::make_get_set('FileInfo', 'path', 'fileSize', 'modification');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfFileInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['FileInfo', 'FileInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfFileInfo', 'FileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FileQuery;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('FileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfFileQuery;
our @ISA = qw(ComplexType);

our @property_list = (
   ['FileQuery', 'FileQuery', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfFileQuery', 'FileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConfigFileQueryFilter;
our @ISA = qw(DynamicData);

our @property_list = (
   ['matchConfigVersion', undef, 1, 0],
);


VIMRuntime::make_get_set('VmConfigFileQueryFilter', 'matchConfigVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConfigFileQueryFlags;
our @ISA = qw(DynamicData);

our @property_list = (
   ['configVersion', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VmConfigFileQueryFlags', 'configVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConfigFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
   ['filter', 'VmConfigFileQueryFilter', undef, 0],
   ['details', 'VmConfigFileQueryFlags', undef, 0],
);


VIMRuntime::make_get_set('VmConfigFileQuery', 'filter', 'details');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TemplateConfigFileQuery;
our @ISA = qw(VmConfigFileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('TemplateConfigFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDiskFileQueryFilter;
our @ISA = qw(DynamicData);

our @property_list = (
   ['diskType', undef, 1, 0],
   ['matchHardwareVersion', undef, 1, 0],
);


VIMRuntime::make_get_set('VmDiskFileQueryFilter', 'diskType', 'matchHardwareVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDiskFileQueryFlags;
our @ISA = qw(DynamicData);

our @property_list = (
   ['diskType', 'boolean', undef, 1],
   ['capacityKb', 'boolean', undef, 1],
   ['hardwareVersion', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VmDiskFileQueryFlags', 'diskType', 'capacityKb', 'hardwareVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDiskFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
   ['filter', 'VmDiskFileQueryFilter', undef, 0],
   ['details', 'VmDiskFileQueryFlags', undef, 0],
);


VIMRuntime::make_get_set('VmDiskFileQuery', 'filter', 'details');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FolderFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('FolderFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmSnapshotFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('VmSnapshotFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IsoImageFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('IsoImageFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FloppyImageFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('FloppyImageFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmNvramFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('VmNvramFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmLogFileQuery;
our @ISA = qw(FileQuery);

our @property_list = (
);


VIMRuntime::make_get_set('VmLogFileQuery');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmConfigFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
   ['configVersion', undef, undef, 0],
);


VIMRuntime::make_get_set('VmConfigFileInfo', 'configVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TemplateConfigFileInfo;
our @ISA = qw(VmConfigFileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('TemplateConfigFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmDiskFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
   ['diskType', undef, undef, 0],
   ['capacityKb', undef, undef, 0],
   ['hardwareVersion', undef, undef, 0],
);


VIMRuntime::make_get_set('VmDiskFileInfo', 'diskType', 'capacityKb', 'hardwareVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FolderFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('FolderFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmSnapshotFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VmSnapshotFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IsoImageFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('IsoImageFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FloppyImageFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('FloppyImageFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmNvramFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VmNvramFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmLogFileInfo;
our @ISA = qw(FileInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VmLogFileInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDatastoreBrowserSearchSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['query', 'FileQuery', 1, 0],
   ['details', 'FileQueryFlags', undef, 0],
   ['searchCaseInsensitive', 'boolean', undef, 0],
   ['matchPattern', undef, 1, 0],
   ['sortFoldersFirst', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostDatastoreBrowserSearchSpec', 'query', 'details', 'searchCaseInsensitive', 'matchPattern', 'sortFoldersFirst');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDatastoreBrowserSearchResults;
our @ISA = qw(DynamicData);

our @property_list = (
   ['datastore', 'ManagedObjectReference', undef, 0],
   ['folderPath', undef, undef, 0],
   ['file', 'FileInfo', 1, 0],
);


VIMRuntime::make_get_set('HostDatastoreBrowserSearchResults', 'datastore', 'folderPath', 'file');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDatastoreBrowserSearchResults;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDatastoreBrowserSearchResults', 'HostDatastoreBrowserSearchResults', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDatastoreBrowserSearchResults', 'HostDatastoreBrowserSearchResults');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreInfo;
our @ISA = qw(DatastoreInfo);

our @property_list = (
   ['vmfs', 'HostVmfsVolume', undef, 0],
);


VIMRuntime::make_get_set('VmfsDatastoreInfo', 'vmfs');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package NasDatastoreInfo;
our @ISA = qw(DatastoreInfo);

our @property_list = (
   ['nas', 'HostNasVolume', undef, 0],
);


VIMRuntime::make_get_set('NasDatastoreInfo', 'nas');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LocalDatastoreInfo;
our @ISA = qw(DatastoreInfo);

our @property_list = (
   ['path', undef, undef, 0],
);


VIMRuntime::make_get_set('LocalDatastoreInfo', 'path');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['diskUuid', undef, undef, 1],
);


VIMRuntime::make_get_set('VmfsDatastoreSpec', 'diskUuid');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreCreateSpec;
our @ISA = qw(VmfsDatastoreSpec);

our @property_list = (
   ['partition', 'HostDiskPartitionSpec', undef, 1],
   ['vmfs', 'HostVmfsSpec', undef, 1],
   ['extent', 'HostScsiDiskPartition', 1, 0],
);


VIMRuntime::make_get_set('VmfsDatastoreCreateSpec', 'partition', 'vmfs', 'extent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreExtendSpec;
our @ISA = qw(VmfsDatastoreSpec);

our @property_list = (
   ['partition', 'HostDiskPartitionSpec', undef, 1],
   ['extent', 'HostScsiDiskPartition', 1, 1],
);


VIMRuntime::make_get_set('VmfsDatastoreExtendSpec', 'partition', 'extent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreBaseOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['layout', 'HostDiskPartitionLayout', undef, 1],
);


VIMRuntime::make_get_set('VmfsDatastoreBaseOption', 'layout');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreSingleExtentOption;
our @ISA = qw(VmfsDatastoreBaseOption);

our @property_list = (
   ['vmfsExtent', 'HostDiskPartitionBlockRange', undef, 1],
);


VIMRuntime::make_get_set('VmfsDatastoreSingleExtentOption', 'vmfsExtent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreAllExtentOption;
our @ISA = qw(VmfsDatastoreSingleExtentOption);

our @property_list = (
);


VIMRuntime::make_get_set('VmfsDatastoreAllExtentOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreMultipleExtentOption;
our @ISA = qw(VmfsDatastoreBaseOption);

our @property_list = (
   ['vmfsExtent', 'HostDiskPartitionBlockRange', 1, 1],
);


VIMRuntime::make_get_set('VmfsDatastoreMultipleExtentOption', 'vmfsExtent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VmfsDatastoreOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['info', 'VmfsDatastoreBaseOption', undef, 1],
   ['spec', 'VmfsDatastoreSpec', undef, 1],
);


VIMRuntime::make_get_set('VmfsDatastoreOption', 'info', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVmfsDatastoreOption;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VmfsDatastoreOption', 'VmfsDatastoreOption', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVmfsDatastoreOption', 'VmfsDatastoreOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDevice;
our @ISA = qw(DynamicData);

our @property_list = (
   ['deviceName', undef, undef, 1],
   ['deviceType', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDevice', 'deviceName', 'deviceType');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiagnosticPartitionCreateOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['storageType', undef, undef, 1],
   ['diagnosticType', undef, undef, 1],
   ['disk', 'HostScsiDisk', undef, 1],
);


VIMRuntime::make_get_set('HostDiagnosticPartitionCreateOption', 'storageType', 'diagnosticType', 'disk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiagnosticPartitionCreateOption;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiagnosticPartitionCreateOption', 'HostDiagnosticPartitionCreateOption', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiagnosticPartitionCreateOption', 'HostDiagnosticPartitionCreateOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiagnosticPartitionCreateSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['storageType', undef, undef, 1],
   ['diagnosticType', undef, undef, 1],
   ['id', 'HostScsiDiskPartition', undef, 1],
   ['partition', 'HostDiskPartitionSpec', undef, 1],
   ['active', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostDiagnosticPartitionCreateSpec', 'storageType', 'diagnosticType', 'id', 'partition', 'active');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiagnosticPartitionCreateDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['layout', 'HostDiskPartitionLayout', undef, 1],
   ['diskUuid', undef, undef, 1],
   ['spec', 'HostDiagnosticPartitionCreateSpec', undef, 1],
);


VIMRuntime::make_get_set('HostDiagnosticPartitionCreateDescription', 'layout', 'diskUuid', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiagnosticPartition;
our @ISA = qw(DynamicData);

our @property_list = (
   ['storageType', undef, undef, 1],
   ['diagnosticType', undef, undef, 1],
   ['slots', undef, undef, 1],
   ['id', 'HostScsiDiskPartition', undef, 1],
);


VIMRuntime::make_get_set('HostDiagnosticPartition', 'storageType', 'diagnosticType', 'slots', 'id');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiagnosticPartition;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiagnosticPartition', 'HostDiagnosticPartition', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiagnosticPartition', 'HostDiagnosticPartition');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskBlockInfoExtent;
our @ISA = qw(DynamicData);

our @property_list = (
   ['logicalStart', undef, undef, 1],
   ['physicalStart', undef, undef, 1],
   ['length', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskBlockInfoExtent', 'logicalStart', 'physicalStart', 'length');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiskBlockInfoExtent;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiskBlockInfoExtent', 'HostDiskBlockInfoExtent', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiskBlockInfoExtent', 'HostDiskBlockInfoExtent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskBlockInfoMapping;
our @ISA = qw(DynamicData);

our @property_list = (
   ['element', undef, undef, 1],
   ['extent', 'HostDiskBlockInfoExtent', 1, 1],
);


VIMRuntime::make_get_set('HostDiskBlockInfoMapping', 'element', 'extent');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiskBlockInfoMapping;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiskBlockInfoMapping', 'HostDiskBlockInfoMapping', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiskBlockInfoMapping', 'HostDiskBlockInfoMapping');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskBlockInfoScsiMapping;
our @ISA = qw(HostDiskBlockInfoMapping);

our @property_list = (
);


VIMRuntime::make_get_set('HostDiskBlockInfoScsiMapping');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskBlockInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['size', undef, undef, 1],
   ['granularity', undef, undef, 1],
   ['minBlockSize', undef, undef, 1],
   ['map', 'HostDiskBlockInfoMapping', 1, 1],
);


VIMRuntime::make_get_set('HostDiskBlockInfo', 'size', 'granularity', 'minBlockSize', 'map');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskDimensionsChs;
our @ISA = qw(DynamicData);

our @property_list = (
   ['cylinder', undef, undef, 1],
   ['head', undef, undef, 1],
   ['sector', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskDimensionsChs', 'cylinder', 'head', 'sector');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskDimensionsLba;
our @ISA = qw(DynamicData);

our @property_list = (
   ['blockSize', undef, undef, 1],
   ['block', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskDimensionsLba', 'blockSize', 'block');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskDimensions;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('HostDiskDimensions');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskManagerLeaseInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['lease', 'ManagedObjectReference', undef, 1],
   ['ddbOption', 'OptionValue', 1, 0],
   ['blockInfo', 'HostDiskBlockInfo', undef, 1],
);


VIMRuntime::make_get_set('HostDiskManagerLeaseInfo', 'lease', 'ddbOption', 'blockInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskPartitionAttributes;
our @ISA = qw(DynamicData);

our @property_list = (
   ['partition', undef, undef, 1],
   ['startSector', undef, undef, 1],
   ['endSector', undef, undef, 1],
   ['type', undef, undef, 1],
   ['logical', 'boolean', undef, 1],
   ['attributes', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskPartitionAttributes', 'partition', 'startSector', 'endSector', 'type', 'logical', 'attributes');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiskPartitionAttributes;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiskPartitionAttributes', 'HostDiskPartitionAttributes', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiskPartitionAttributes', 'HostDiskPartitionAttributes');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskPartitionBlockRange;
our @ISA = qw(DynamicData);

our @property_list = (
   ['partition', undef, undef, 0],
   ['type', undef, undef, 1],
   ['start', 'HostDiskDimensionsLba', undef, 1],
   ['end', 'HostDiskDimensionsLba', undef, 1],
);


VIMRuntime::make_get_set('HostDiskPartitionBlockRange', 'partition', 'type', 'start', 'end');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiskPartitionBlockRange;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiskPartitionBlockRange', 'HostDiskPartitionBlockRange', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiskPartitionBlockRange', 'HostDiskPartitionBlockRange');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskPartitionSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['chs', 'HostDiskDimensionsChs', undef, 0],
   ['totalSectors', undef, undef, 0],
   ['partition', 'HostDiskPartitionAttributes', 1, 0],
);


VIMRuntime::make_get_set('HostDiskPartitionSpec', 'chs', 'totalSectors', 'partition');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskPartitionLayout;
our @ISA = qw(DynamicData);

our @property_list = (
   ['total', 'HostDiskDimensionsLba', undef, 0],
   ['partition', 'HostDiskPartitionBlockRange', 1, 1],
);


VIMRuntime::make_get_set('HostDiskPartitionLayout', 'total', 'partition');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskPartitionInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['deviceName', undef, undef, 1],
   ['spec', 'HostDiskPartitionSpec', undef, 1],
   ['layout', 'HostDiskPartitionLayout', undef, 1],
);


VIMRuntime::make_get_set('HostDiskPartitionInfo', 'deviceName', 'spec', 'layout');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiskPartitionInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiskPartitionInfo', 'HostDiskPartitionInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiskPartitionInfo', 'HostDiskPartitionInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDnsConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['dhcp', 'boolean', undef, 1],
   ['virtualNicDevice', undef, undef, 0],
   ['hostName', undef, undef, 1],
   ['domainName', undef, undef, 1],
   ['address', undef, 1, 0],
   ['searchDomain', undef, 1, 0],
);


VIMRuntime::make_get_set('HostDnsConfig', 'dhcp', 'virtualNicDevice', 'hostName', 'domainName', 'address', 'searchDomain');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ModeInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['browse', undef, undef, 0],
   ['read', undef, undef, 1],
   ['modify', undef, undef, 1],
   ['use', undef, undef, 1],
   ['admin', undef, undef, 0],
   ['full', undef, undef, 1],
);


VIMRuntime::make_get_set('ModeInfo', 'browse', 'read', 'modify', 'use', 'admin', 'full');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFileAccess;
our @ISA = qw(DynamicData);

our @property_list = (
   ['who', undef, undef, 1],
   ['what', undef, undef, 1],
);


VIMRuntime::make_get_set('HostFileAccess', 'who', 'what');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFileSystemVolumeInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['volumeTypeList', undef, 1, 0],
   ['mountInfo', 'HostFileSystemMountInfo', 1, 0],
);


VIMRuntime::make_get_set('HostFileSystemVolumeInfo', 'volumeTypeList', 'mountInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFileSystemMountInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['mountInfo', 'HostMountInfo', undef, 1],
   ['volume', 'HostFileSystemVolume', undef, 1],
);


VIMRuntime::make_get_set('HostFileSystemMountInfo', 'mountInfo', 'volume');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostFileSystemMountInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostFileSystemMountInfo', 'HostFileSystemMountInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostFileSystemMountInfo', 'HostFileSystemMountInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFileSystemVolume;
our @ISA = qw(DynamicData);

our @property_list = (
   ['type', undef, undef, 1],
   ['name', undef, undef, 1],
   ['capacity', undef, undef, 1],
);


VIMRuntime::make_get_set('HostFileSystemVolume', 'type', 'name', 'capacity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNasVolumeSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['remoteHost', undef, undef, 1],
   ['remotePath', undef, undef, 1],
   ['localPath', undef, undef, 1],
   ['accessMode', undef, undef, 1],
);


VIMRuntime::make_get_set('HostNasVolumeSpec', 'remoteHost', 'remotePath', 'localPath', 'accessMode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNasVolume;
our @ISA = qw(HostFileSystemVolume);

our @property_list = (
   ['remoteHost', undef, undef, 1],
   ['remotePath', undef, undef, 1],
);


VIMRuntime::make_get_set('HostNasVolume', 'remoteHost', 'remotePath');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostLocalFileSystemVolumeSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['device', undef, undef, 1],
   ['localPath', undef, undef, 1],
);


VIMRuntime::make_get_set('HostLocalFileSystemVolumeSpec', 'device', 'localPath');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostLocalFileSystemVolume;
our @ISA = qw(HostFileSystemVolume);

our @property_list = (
   ['device', undef, undef, 1],
);


VIMRuntime::make_get_set('HostLocalFileSystemVolume', 'device');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFirewallDefaultPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['incomingBlocked', 'boolean', undef, 0],
   ['outgoingBlocked', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostFirewallDefaultPolicy', 'incomingBlocked', 'outgoingBlocked');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFirewallInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['defaultPolicy', 'HostFirewallDefaultPolicy', undef, 1],
   ['ruleset', 'HostFirewallRuleset', 1, 0],
);


VIMRuntime::make_get_set('HostFirewallInfo', 'defaultPolicy', 'ruleset');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostHardwareInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['systemInfo', 'HostSystemInfo', undef, 1],
   ['cpuInfo', 'HostCpuInfo', undef, 1],
   ['cpuPkg', 'HostCpuPackage', 1, 1],
   ['memorySize', undef, undef, 1],
   ['numaInfo', 'HostNumaInfo', undef, 0],
   ['pciDevice', 'HostPciDevice', 1, 0],
   ['cpuFeature', 'HostCpuIdInfo', 1, 0],
);


VIMRuntime::make_get_set('HostHardwareInfo', 'systemInfo', 'cpuInfo', 'cpuPkg', 'memorySize', 'numaInfo', 'pciDevice', 'cpuFeature');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostSystemInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vendor', undef, undef, 1],
   ['model', undef, undef, 1],
   ['uuid', undef, undef, 1],
);


VIMRuntime::make_get_set('HostSystemInfo', 'vendor', 'model', 'uuid');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCpuInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['numCpuPackages', undef, undef, 1],
   ['numCpuCores', undef, undef, 1],
   ['numCpuThreads', undef, undef, 1],
   ['hz', undef, undef, 1],
);


VIMRuntime::make_get_set('HostCpuInfo', 'numCpuPackages', 'numCpuCores', 'numCpuThreads', 'hz');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostCpuPackage;
our @ISA = qw(DynamicData);

our @property_list = (
   ['index', undef, undef, 1],
   ['vendor', undef, undef, 1],
   ['hz', undef, undef, 1],
   ['busHz', undef, undef, 1],
   ['description', undef, undef, 1],
   ['threadId', undef, 1, 1],
   ['cpuFeature', 'HostCpuIdInfo', 1, 0],
);


VIMRuntime::make_get_set('HostCpuPackage', 'index', 'vendor', 'hz', 'busHz', 'description', 'threadId', 'cpuFeature');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostCpuPackage;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostCpuPackage', 'HostCpuPackage', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostCpuPackage', 'HostCpuPackage');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNumaInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['type', undef, undef, 1],
   ['numNodes', undef, undef, 1],
   ['numaNode', 'HostNumaNode', 1, 0],
);


VIMRuntime::make_get_set('HostNumaInfo', 'type', 'numNodes', 'numaNode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNumaNode;
our @ISA = qw(DynamicData);

our @property_list = (
   ['typeId', undef, undef, 1],
   ['cpuID', undef, 1, 1],
   ['memoryRangeBegin', undef, undef, 1],
   ['memoryRangeLength', undef, undef, 1],
);


VIMRuntime::make_get_set('HostNumaNode', 'typeId', 'cpuID', 'memoryRangeBegin', 'memoryRangeLength');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostNumaNode;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostNumaNode', 'HostNumaNode', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostNumaNode', 'HostNumaNode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostHostBusAdapter;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 0],
   ['device', undef, undef, 1],
   ['bus', undef, undef, 1],
   ['status', undef, undef, 1],
   ['model', undef, undef, 1],
   ['driver', undef, undef, 0],
   ['pci', undef, undef, 0],
);


VIMRuntime::make_get_set('HostHostBusAdapter', 'key', 'device', 'bus', 'status', 'model', 'driver', 'pci');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostHostBusAdapter;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostHostBusAdapter', 'HostHostBusAdapter', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostHostBusAdapter', 'HostHostBusAdapter');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostParallelScsiHba;
our @ISA = qw(HostHostBusAdapter);

our @property_list = (
);


VIMRuntime::make_get_set('HostParallelScsiHba');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostBlockHba;
our @ISA = qw(HostHostBusAdapter);

our @property_list = (
);


VIMRuntime::make_get_set('HostBlockHba');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFibreChannelHba;
our @ISA = qw(HostHostBusAdapter);

our @property_list = (
   ['portWorldWideName', undef, undef, 1],
   ['nodeWorldWideName', undef, undef, 1],
   ['portType', 'FibreChannelPortType', undef, 1],
   ['speed', undef, undef, 1],
);


VIMRuntime::make_get_set('HostFibreChannelHba', 'portWorldWideName', 'nodeWorldWideName', 'portType', 'speed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaDiscoveryCapabilities;
our @ISA = qw(DynamicData);

our @property_list = (
   ['iSnsDiscoverySettable', 'boolean', undef, 1],
   ['slpDiscoverySettable', 'boolean', undef, 1],
   ['staticTargetDiscoverySettable', 'boolean', undef, 1],
   ['sendTargetsDiscoverySettable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostInternetScsiHbaDiscoveryCapabilities', 'iSnsDiscoverySettable', 'slpDiscoverySettable', 'staticTargetDiscoverySettable', 'sendTargetsDiscoverySettable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaDiscoveryProperties;
our @ISA = qw(DynamicData);

our @property_list = (
   ['iSnsDiscoveryEnabled', 'boolean', undef, 1],
   ['iSnsDiscoveryMethod', undef, undef, 0],
   ['iSnsHost', undef, undef, 0],
   ['slpDiscoveryEnabled', 'boolean', undef, 1],
   ['slpDiscoveryMethod', undef, undef, 0],
   ['slpHost', undef, undef, 0],
   ['staticTargetDiscoveryEnabled', 'boolean', undef, 1],
   ['sendTargetsDiscoveryEnabled', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostInternetScsiHbaDiscoveryProperties', 'iSnsDiscoveryEnabled', 'iSnsDiscoveryMethod', 'iSnsHost', 'slpDiscoveryEnabled', 'slpDiscoveryMethod', 'slpHost', 'staticTargetDiscoveryEnabled', 'sendTargetsDiscoveryEnabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaAuthenticationCapabilities;
our @ISA = qw(DynamicData);

our @property_list = (
   ['chapAuthSettable', 'boolean', undef, 1],
   ['krb5AuthSettable', 'boolean', undef, 1],
   ['srpAuthSettable', 'boolean', undef, 1],
   ['spkmAuthSettable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostInternetScsiHbaAuthenticationCapabilities', 'chapAuthSettable', 'krb5AuthSettable', 'srpAuthSettable', 'spkmAuthSettable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaAuthenticationProperties;
our @ISA = qw(DynamicData);

our @property_list = (
   ['chapAuthEnabled', 'boolean', undef, 1],
   ['chapName', undef, undef, 0],
   ['chapSecret', undef, undef, 0],
);


VIMRuntime::make_get_set('HostInternetScsiHbaAuthenticationProperties', 'chapAuthEnabled', 'chapName', 'chapSecret');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaIPCapabilities;
our @ISA = qw(DynamicData);

our @property_list = (
   ['addressSettable', 'boolean', undef, 1],
   ['ipConfigurationMethodSettable', 'boolean', undef, 1],
   ['subnetMaskSettable', 'boolean', undef, 1],
   ['defaultGatewaySettable', 'boolean', undef, 1],
   ['primaryDnsServerAddressSettable', 'boolean', undef, 1],
   ['alternateDnsServerAddressSettable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostInternetScsiHbaIPCapabilities', 'addressSettable', 'ipConfigurationMethodSettable', 'subnetMaskSettable', 'defaultGatewaySettable', 'primaryDnsServerAddressSettable', 'alternateDnsServerAddressSettable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaIPProperties;
our @ISA = qw(DynamicData);

our @property_list = (
   ['mac', undef, undef, 0],
   ['address', undef, undef, 0],
   ['dhcpConfigurationEnabled', 'boolean', undef, 1],
   ['subnetMask', undef, undef, 0],
   ['defaultGateway', undef, undef, 0],
   ['primaryDnsServerAddress', undef, undef, 0],
   ['alternateDnsServerAddress', undef, undef, 0],
);


VIMRuntime::make_get_set('HostInternetScsiHbaIPProperties', 'mac', 'address', 'dhcpConfigurationEnabled', 'subnetMask', 'defaultGateway', 'primaryDnsServerAddress', 'alternateDnsServerAddress');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaSendTarget;
our @ISA = qw(DynamicData);

our @property_list = (
   ['address', undef, undef, 1],
   ['port', undef, undef, 0],
);


VIMRuntime::make_get_set('HostInternetScsiHbaSendTarget', 'address', 'port');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostInternetScsiHbaSendTarget;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostInternetScsiHbaSendTarget', 'HostInternetScsiHbaSendTarget', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostInternetScsiHbaSendTarget', 'HostInternetScsiHbaSendTarget');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHbaStaticTarget;
our @ISA = qw(DynamicData);

our @property_list = (
   ['address', undef, undef, 1],
   ['port', undef, undef, 0],
   ['iScsiName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostInternetScsiHbaStaticTarget', 'address', 'port', 'iScsiName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostInternetScsiHbaStaticTarget;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostInternetScsiHbaStaticTarget', 'HostInternetScsiHbaStaticTarget', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostInternetScsiHbaStaticTarget', 'HostInternetScsiHbaStaticTarget');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiHba;
our @ISA = qw(HostHostBusAdapter);

our @property_list = (
   ['isSoftwareBased', 'boolean', undef, 1],
   ['discoveryCapabilities', 'HostInternetScsiHbaDiscoveryCapabilities', undef, 1],
   ['discoveryProperties', 'HostInternetScsiHbaDiscoveryProperties', undef, 1],
   ['authenticationCapabilities', 'HostInternetScsiHbaAuthenticationCapabilities', undef, 1],
   ['authenticationProperties', 'HostInternetScsiHbaAuthenticationProperties', undef, 1],
   ['ipCapabilities', 'HostInternetScsiHbaIPCapabilities', undef, 1],
   ['ipProperties', 'HostInternetScsiHbaIPProperties', undef, 1],
   ['iScsiName', undef, undef, 1],
   ['iScsiAlias', undef, undef, 0],
   ['configuredSendTarget', 'HostInternetScsiHbaSendTarget', 1, 0],
   ['configuredStaticTarget', 'HostInternetScsiHbaStaticTarget', 1, 0],
   ['maxSpeedMb', undef, undef, 0],
   ['currentSpeedMb', undef, undef, 0],
);


VIMRuntime::make_get_set('HostInternetScsiHba', 'isSoftwareBased', 'discoveryCapabilities', 'discoveryProperties', 'authenticationCapabilities', 'authenticationProperties', 'ipCapabilities', 'ipProperties', 'iScsiName', 'iScsiAlias', 'configuredSendTarget', 'configuredStaticTarget', 'maxSpeedMb', 'currentSpeedMb');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostIpConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['dhcp', 'boolean', undef, 1],
   ['ipAddress', undef, undef, 0],
   ['subnetMask', undef, undef, 0],
);


VIMRuntime::make_get_set('HostIpConfig', 'dhcp', 'ipAddress', 'subnetMask');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostIpRouteConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['defaultGateway', undef, undef, 0],
   ['gatewayDevice', undef, undef, 0],
);


VIMRuntime::make_get_set('HostIpRouteConfig', 'defaultGateway', 'gatewayDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostAccountSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['id', undef, undef, 1],
   ['password', undef, undef, 0],
   ['description', undef, undef, 0],
);


VIMRuntime::make_get_set('HostAccountSpec', 'id', 'password', 'description');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostPosixAccountSpec;
our @ISA = qw(HostAccountSpec);

our @property_list = (
   ['posixId', undef, undef, 0],
   ['shellAccess', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostPosixAccountSpec', 'posixId', 'shellAccess');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ServiceConsoleReservationInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['serviceConsoleReservedCfg', undef, undef, 1],
   ['serviceConsoleReserved', undef, undef, 1],
   ['unreserved', undef, undef, 1],
);


VIMRuntime::make_get_set('ServiceConsoleReservationInfo', 'serviceConsoleReservedCfg', 'serviceConsoleReserved', 'unreserved');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostMountInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['path', undef, undef, 0],
   ['accessMode', undef, undef, 1],
);


VIMRuntime::make_get_set('HostMountInfo', 'path', 'accessMode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostMultipathInfoLogicalUnitPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['policy', undef, undef, 1],
);


VIMRuntime::make_get_set('HostMultipathInfoLogicalUnitPolicy', 'policy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostMultipathInfoFixedLogicalUnitPolicy;
our @ISA = qw(HostMultipathInfoLogicalUnitPolicy);

our @property_list = (
   ['prefer', undef, undef, 1],
);


VIMRuntime::make_get_set('HostMultipathInfoFixedLogicalUnitPolicy', 'prefer');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostMultipathInfoLogicalUnit;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['id', undef, undef, 1],
   ['lun', undef, undef, 1],
   ['path', 'HostMultipathInfoPath', 1, 1],
   ['policy', 'HostMultipathInfoLogicalUnitPolicy', undef, 1],
);


VIMRuntime::make_get_set('HostMultipathInfoLogicalUnit', 'key', 'id', 'lun', 'path', 'policy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostMultipathInfoLogicalUnit;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostMultipathInfoLogicalUnit', 'HostMultipathInfoLogicalUnit', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostMultipathInfoLogicalUnit', 'HostMultipathInfoLogicalUnit');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostMultipathInfoPath;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['name', undef, undef, 1],
   ['pathState', undef, undef, 1],
   ['adapter', undef, undef, 1],
   ['lun', undef, undef, 1],
   ['transport', 'HostTargetTransport', undef, 0],
);


VIMRuntime::make_get_set('HostMultipathInfoPath', 'key', 'name', 'pathState', 'adapter', 'lun', 'transport');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostMultipathInfoPath;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostMultipathInfoPath', 'HostMultipathInfoPath', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostMultipathInfoPath', 'HostMultipathInfoPath');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostMultipathInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['lun', 'HostMultipathInfoLogicalUnit', 1, 0],
);


VIMRuntime::make_get_set('HostMultipathInfo', 'lun');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetCapabilities;
our @ISA = qw(DynamicData);

our @property_list = (
   ['canSetPhysicalNicLinkSpeed', 'boolean', undef, 1],
   ['supportsNicTeaming', 'boolean', undef, 1],
   ['nicTeamingPolicy', undef, 1, 0],
   ['supportsVlan', 'boolean', undef, 1],
   ['usesServiceConsoleNic', 'boolean', undef, 1],
   ['supportsNetworkHints', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostNetCapabilities', 'canSetPhysicalNicLinkSpeed', 'supportsNicTeaming', 'nicTeamingPolicy', 'supportsVlan', 'usesServiceConsoleNic', 'supportsNetworkHints');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetOffloadCapabilities;
our @ISA = qw(DynamicData);

our @property_list = (
   ['csumOffload', 'boolean', undef, 0],
   ['tcpSegmentation', 'boolean', undef, 0],
   ['zeroCopyXmit', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostNetOffloadCapabilities', 'csumOffload', 'tcpSegmentation', 'zeroCopyXmit');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetworkConfigResult;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vnicDevice', undef, 1, 0],
   ['consoleVnicDevice', undef, 1, 0],
);


VIMRuntime::make_get_set('HostNetworkConfigResult', 'vnicDevice', 'consoleVnicDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetworkConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vswitch', 'HostVirtualSwitchConfig', 1, 0],
   ['portgroup', 'HostPortGroupConfig', 1, 0],
   ['pnic', 'PhysicalNicConfig', 1, 0],
   ['vnic', 'HostVirtualNicConfig', 1, 0],
   ['consoleVnic', 'HostVirtualNicConfig', 1, 0],
   ['dnsConfig', 'HostDnsConfig', undef, 0],
   ['ipRouteConfig', 'HostIpRouteConfig', undef, 0],
   ['consoleIpRouteConfig', 'HostIpRouteConfig', undef, 0],
);


VIMRuntime::make_get_set('HostNetworkConfig', 'vswitch', 'portgroup', 'pnic', 'vnic', 'consoleVnic', 'dnsConfig', 'ipRouteConfig', 'consoleIpRouteConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetworkInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vswitch', 'HostVirtualSwitch', 1, 0],
   ['portgroup', 'HostPortGroup', 1, 0],
   ['pnic', 'PhysicalNic', 1, 0],
   ['vnic', 'HostVirtualNic', 1, 0],
   ['consoleVnic', 'HostVirtualNic', 1, 0],
   ['dnsConfig', 'HostDnsConfig', undef, 0],
   ['ipRouteConfig', 'HostIpRouteConfig', undef, 0],
   ['consoleIpRouteConfig', 'HostIpRouteConfig', undef, 0],
);


VIMRuntime::make_get_set('HostNetworkInfo', 'vswitch', 'portgroup', 'pnic', 'vnic', 'consoleVnic', 'dnsConfig', 'ipRouteConfig', 'consoleIpRouteConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetworkSecurityPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['allowPromiscuous', 'boolean', undef, 0],
   ['macChanges', 'boolean', undef, 0],
   ['forgedTransmits', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostNetworkSecurityPolicy', 'allowPromiscuous', 'macChanges', 'forgedTransmits');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetworkTrafficShapingPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['enabled', 'boolean', undef, 0],
   ['averageBandwidth', undef, undef, 0],
   ['peakBandwidth', undef, undef, 0],
   ['burstSize', undef, undef, 0],
);


VIMRuntime::make_get_set('HostNetworkTrafficShapingPolicy', 'enabled', 'averageBandwidth', 'peakBandwidth', 'burstSize');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNicFailureCriteria;
our @ISA = qw(DynamicData);

our @property_list = (
   ['checkSpeed', undef, undef, 0],
   ['speed', undef, undef, 0],
   ['checkDuplex', 'boolean', undef, 0],
   ['fullDuplex', 'boolean', undef, 0],
   ['checkErrorPercent', 'boolean', undef, 0],
   ['percentage', undef, undef, 0],
   ['checkBeacon', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostNicFailureCriteria', 'checkSpeed', 'speed', 'checkDuplex', 'fullDuplex', 'checkErrorPercent', 'percentage', 'checkBeacon');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNicOrderPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['activeNic', undef, 1, 0],
   ['standbyNic', undef, 1, 0],
);


VIMRuntime::make_get_set('HostNicOrderPolicy', 'activeNic', 'standbyNic');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNicTeamingPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['policy', undef, undef, 0],
   ['reversePolicy', 'boolean', undef, 0],
   ['notifySwitches', 'boolean', undef, 0],
   ['rollingOrder', 'boolean', undef, 0],
   ['failureCriteria', 'HostNicFailureCriteria', undef, 0],
   ['nicOrder', 'HostNicOrderPolicy', undef, 0],
);


VIMRuntime::make_get_set('HostNicTeamingPolicy', 'policy', 'reversePolicy', 'notifySwitches', 'rollingOrder', 'failureCriteria', 'nicOrder');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostNetworkPolicy;
our @ISA = qw(DynamicData);

our @property_list = (
   ['security', 'HostNetworkSecurityPolicy', undef, 0],
   ['nicTeaming', 'HostNicTeamingPolicy', undef, 0],
   ['offloadPolicy', 'HostNetOffloadCapabilities', undef, 0],
   ['shapingPolicy', 'HostNetworkTrafficShapingPolicy', undef, 0],
);


VIMRuntime::make_get_set('HostNetworkPolicy', 'security', 'nicTeaming', 'offloadPolicy', 'shapingPolicy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostPciDevice;
our @ISA = qw(DynamicData);

our @property_list = (
   ['id', undef, undef, 1],
   ['classId', undef, undef, 1],
   ['bus', undef, undef, 1],
   ['slot', undef, undef, 1],
   ['function', undef, undef, 1],
   ['vendorId', undef, undef, 1],
   ['subVendorId', undef, undef, 1],
   ['vendorName', undef, undef, 1],
   ['deviceId', undef, undef, 1],
   ['subDeviceId', undef, undef, 1],
   ['deviceName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostPciDevice', 'id', 'classId', 'bus', 'slot', 'function', 'vendorId', 'subVendorId', 'vendorName', 'deviceId', 'subDeviceId', 'deviceName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostPciDevice;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostPciDevice', 'HostPciDevice', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostPciDevice', 'HostPciDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['ip', 'HostIpConfig', undef, 0],
   ['linkSpeed', 'PhysicalNicLinkInfo', undef, 0],
);


VIMRuntime::make_get_set('PhysicalNicSpec', 'ip', 'linkSpeed');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['device', undef, undef, 1],
   ['spec', 'PhysicalNicSpec', undef, 1],
);


VIMRuntime::make_get_set('PhysicalNicConfig', 'device', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPhysicalNicConfig;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PhysicalNicConfig', 'PhysicalNicConfig', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPhysicalNicConfig', 'PhysicalNicConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicLinkInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['speedMb', undef, undef, 1],
   ['duplex', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('PhysicalNicLinkInfo', 'speedMb', 'duplex');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPhysicalNicLinkInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PhysicalNicLinkInfo', 'PhysicalNicLinkInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPhysicalNicLinkInfo', 'PhysicalNicLinkInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicHint;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vlanId', undef, undef, 0],
);


VIMRuntime::make_get_set('PhysicalNicHint', 'vlanId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicIpHint;
our @ISA = qw(PhysicalNicHint);

our @property_list = (
   ['ipSubnet', undef, undef, 1],
);


VIMRuntime::make_get_set('PhysicalNicIpHint', 'ipSubnet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPhysicalNicIpHint;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PhysicalNicIpHint', 'PhysicalNicIpHint', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPhysicalNicIpHint', 'PhysicalNicIpHint');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicNameHint;
our @ISA = qw(PhysicalNicHint);

our @property_list = (
   ['network', undef, undef, 1],
);


VIMRuntime::make_get_set('PhysicalNicNameHint', 'network');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPhysicalNicNameHint;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PhysicalNicNameHint', 'PhysicalNicNameHint', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPhysicalNicNameHint', 'PhysicalNicNameHint');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNicHintInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['device', undef, undef, 1],
   ['subnet', 'PhysicalNicIpHint', 1, 0],
   ['network', 'PhysicalNicNameHint', 1, 0],
);


VIMRuntime::make_get_set('PhysicalNicHintInfo', 'device', 'subnet', 'network');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPhysicalNicHintInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PhysicalNicHintInfo', 'PhysicalNicHintInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPhysicalNicHintInfo', 'PhysicalNicHintInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package PhysicalNic;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 0],
   ['device', undef, undef, 1],
   ['pci', undef, undef, 1],
   ['driver', undef, undef, 0],
   ['linkSpeed', 'PhysicalNicLinkInfo', undef, 0],
   ['validLinkSpecification', 'PhysicalNicLinkInfo', 1, 0],
   ['spec', 'PhysicalNicSpec', undef, 1],
);


VIMRuntime::make_get_set('PhysicalNic', 'key', 'device', 'pci', 'driver', 'linkSpeed', 'validLinkSpecification', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfPhysicalNic;
our @ISA = qw(ComplexType);

our @property_list = (
   ['PhysicalNic', 'PhysicalNic', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfPhysicalNic', 'PhysicalNic');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostPortGroupSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['vlanId', undef, undef, 1],
   ['vswitchName', undef, undef, 1],
   ['policy', 'HostNetworkPolicy', undef, 1],
);


VIMRuntime::make_get_set('HostPortGroupSpec', 'name', 'vlanId', 'vswitchName', 'policy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostPortGroupConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['changeOperation', undef, undef, 0],
   ['spec', 'HostPortGroupSpec', undef, 0],
);


VIMRuntime::make_get_set('HostPortGroupConfig', 'changeOperation', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostPortGroupConfig;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostPortGroupConfig', 'HostPortGroupConfig', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostPortGroupConfig', 'HostPortGroupConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostPortGroupPort;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 0],
   ['mac', undef, 1, 0],
   ['type', undef, undef, 1],
);


VIMRuntime::make_get_set('HostPortGroupPort', 'key', 'mac', 'type');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostPortGroupPort;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostPortGroupPort', 'HostPortGroupPort', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostPortGroupPort', 'HostPortGroupPort');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostPortGroup;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 0],
   ['port', 'HostPortGroupPort', 1, 0],
   ['vswitch', undef, undef, 0],
   ['computedPolicy', 'HostNetworkPolicy', undef, 1],
   ['spec', 'HostPortGroupSpec', undef, 1],
);


VIMRuntime::make_get_set('HostPortGroup', 'key', 'port', 'vswitch', 'computedPolicy', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostPortGroup;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostPortGroup', 'HostPortGroup', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostPortGroup', 'HostPortGroup');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFirewallRule;
our @ISA = qw(DynamicData);

our @property_list = (
   ['port', undef, undef, 1],
   ['endPort', undef, undef, 0],
   ['direction', 'HostFirewallRuleDirection', undef, 1],
   ['protocol', undef, undef, 1],
);


VIMRuntime::make_get_set('HostFirewallRule', 'port', 'endPort', 'direction', 'protocol');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostFirewallRule;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostFirewallRule', 'HostFirewallRule', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostFirewallRule', 'HostFirewallRule');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFirewallRuleset;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['label', undef, undef, 1],
   ['required', 'boolean', undef, 1],
   ['rule', 'HostFirewallRule', 1, 1],
   ['service', undef, undef, 0],
   ['enabled', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostFirewallRuleset', 'key', 'label', 'required', 'rule', 'service', 'enabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostFirewallRuleset;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostFirewallRuleset', 'HostFirewallRuleset', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostFirewallRuleset', 'HostFirewallRuleset');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostRuntimeInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['connectionState', 'HostSystemConnectionState', undef, 1],
   ['inMaintenanceMode', 'boolean', undef, 1],
   ['bootTime', undef, undef, 0],
);


VIMRuntime::make_get_set('HostRuntimeInfo', 'connectionState', 'inMaintenanceMode', 'bootTime');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostScsiDiskPartition;
our @ISA = qw(DynamicData);

our @property_list = (
   ['diskName', undef, undef, 1],
   ['partition', undef, undef, 1],
);


VIMRuntime::make_get_set('HostScsiDiskPartition', 'diskName', 'partition');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostScsiDiskPartition;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostScsiDiskPartition', 'HostScsiDiskPartition', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostScsiDiskPartition', 'HostScsiDiskPartition');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostScsiDisk;
our @ISA = qw(ScsiLun);

our @property_list = (
   ['capacity', 'HostDiskDimensionsLba', undef, 1],
   ['devicePath', undef, undef, 1],
);


VIMRuntime::make_get_set('HostScsiDisk', 'capacity', 'devicePath');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostScsiDisk;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostScsiDisk', 'HostScsiDisk', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostScsiDisk', 'HostScsiDisk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScsiLunDurableName;
our @ISA = qw(DynamicData);

our @property_list = (
   ['namespace', undef, undef, 1],
   ['namespaceId', undef, undef, 1],
   ['data', undef, 1, 0],
);


VIMRuntime::make_get_set('ScsiLunDurableName', 'namespace', 'namespaceId', 'data');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScsiLun;
our @ISA = qw(HostDevice);

our @property_list = (
   ['key', undef, undef, 0],
   ['uuid', undef, undef, 1],
   ['canonicalName', undef, undef, 0],
   ['lunType', undef, undef, 1],
   ['vendor', undef, undef, 0],
   ['model', undef, undef, 0],
   ['revision', undef, undef, 0],
   ['scsiLevel', undef, undef, 0],
   ['serialNumber', undef, undef, 0],
   ['durableName', 'ScsiLunDurableName', undef, 0],
   ['queueDepth', undef, undef, 0],
   ['operationalState', undef, 1, 1],
);


VIMRuntime::make_get_set('ScsiLun', 'key', 'uuid', 'canonicalName', 'lunType', 'vendor', 'model', 'revision', 'scsiLevel', 'serialNumber', 'durableName', 'queueDepth', 'operationalState');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfScsiLun;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ScsiLun', 'ScsiLun', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfScsiLun', 'ScsiLun');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostScsiTopologyInterface;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['adapter', undef, undef, 1],
   ['target', 'HostScsiTopologyTarget', 1, 0],
);


VIMRuntime::make_get_set('HostScsiTopologyInterface', 'key', 'adapter', 'target');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostScsiTopologyInterface;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostScsiTopologyInterface', 'HostScsiTopologyInterface', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostScsiTopologyInterface', 'HostScsiTopologyInterface');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostScsiTopologyTarget;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['target', undef, undef, 1],
   ['lun', 'HostScsiTopologyLun', 1, 0],
   ['transport', 'HostTargetTransport', undef, 0],
);


VIMRuntime::make_get_set('HostScsiTopologyTarget', 'key', 'target', 'lun', 'transport');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostScsiTopologyTarget;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostScsiTopologyTarget', 'HostScsiTopologyTarget', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostScsiTopologyTarget', 'HostScsiTopologyTarget');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostScsiTopologyLun;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['lun', undef, undef, 1],
   ['scsiLun', undef, undef, 1],
);


VIMRuntime::make_get_set('HostScsiTopologyLun', 'key', 'lun', 'scsiLun');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostScsiTopologyLun;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostScsiTopologyLun', 'HostScsiTopologyLun', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostScsiTopologyLun', 'HostScsiTopologyLun');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostScsiTopology;
our @ISA = qw(DynamicData);

our @property_list = (
   ['adapter', 'HostScsiTopologyInterface', 1, 0],
);


VIMRuntime::make_get_set('HostScsiTopology', 'adapter');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostService;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['label', undef, undef, 1],
   ['required', 'boolean', undef, 1],
   ['uninstallable', 'boolean', undef, 1],
   ['running', 'boolean', undef, 1],
   ['ruleset', undef, 1, 0],
   ['policy', undef, undef, 1],
);


VIMRuntime::make_get_set('HostService', 'key', 'label', 'required', 'uninstallable', 'running', 'ruleset', 'policy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostService;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostService', 'HostService', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostService', 'HostService');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostServiceInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['service', 'HostService', 1, 0],
);


VIMRuntime::make_get_set('HostServiceInfo', 'service');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostSnmpConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['autoStartMasterSnmpAgentEnabled', 'boolean', undef, 0],
   ['startupScript', undef, undef, 0],
   ['configFile', undef, undef, 0],
   ['vmwareSubagentEnabled', 'boolean', undef, 0],
   ['vmwareTrapsEnabled', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostSnmpConfig', 'autoStartMasterSnmpAgentEnabled', 'startupScript', 'configFile', 'vmwareSubagentEnabled', 'vmwareTrapsEnabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostStorageDeviceInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['hostBusAdapter', 'HostHostBusAdapter', 1, 0],
   ['scsiLun', 'ScsiLun', 1, 0],
   ['scsiTopology', 'HostScsiTopology', undef, 0],
   ['multipathInfo', 'HostMultipathInfo', undef, 0],
   ['softwareInternetScsiEnabled', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostStorageDeviceInfo', 'hostBusAdapter', 'scsiLun', 'scsiTopology', 'multipathInfo', 'softwareInternetScsiEnabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostHardwareSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vendor', undef, undef, 1],
   ['model', undef, undef, 1],
   ['uuid', undef, undef, 1],
   ['memorySize', undef, undef, 1],
   ['cpuModel', undef, undef, 1],
   ['cpuMhz', undef, undef, 1],
   ['numCpuPkgs', undef, undef, 1],
   ['numCpuCores', undef, undef, 1],
   ['numCpuThreads', undef, undef, 1],
   ['numNics', undef, undef, 1],
   ['numHBAs', undef, undef, 1],
);


VIMRuntime::make_get_set('HostHardwareSummary', 'vendor', 'model', 'uuid', 'memorySize', 'cpuModel', 'cpuMhz', 'numCpuPkgs', 'numCpuCores', 'numCpuThreads', 'numNics', 'numHBAs');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostListSummaryQuickStats;
our @ISA = qw(DynamicData);

our @property_list = (
   ['overallCpuUsage', undef, undef, 0],
   ['overallMemoryUsage', undef, undef, 0],
   ['distributedCpuFairness', undef, undef, 0],
   ['distributedMemoryFairness', undef, undef, 0],
);


VIMRuntime::make_get_set('HostListSummaryQuickStats', 'overallCpuUsage', 'overallMemoryUsage', 'distributedCpuFairness', 'distributedMemoryFairness');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostConfigSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['port', undef, undef, 1],
   ['product', 'AboutInfo', undef, 0],
   ['vmotionEnabled', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostConfigSummary', 'name', 'port', 'product', 'vmotionEnabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostListSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 0],
   ['hardware', 'HostHardwareSummary', undef, 0],
   ['runtime', 'HostRuntimeInfo', undef, 0],
   ['config', 'HostConfigSummary', undef, 1],
   ['quickStats', 'HostListSummaryQuickStats', undef, 1],
   ['overallStatus', 'ManagedEntityStatus', undef, 1],
   ['rebootRequired', 'boolean', undef, 1],
   ['customValue', 'CustomFieldValue', 1, 0],
);


VIMRuntime::make_get_set('HostListSummary', 'host', 'hardware', 'runtime', 'config', 'quickStats', 'overallStatus', 'rebootRequired', 'customValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostSystemResourceInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['config', 'ResourceConfigSpec', undef, 0],
   ['child', 'HostSystemResourceInfo', 1, 0],
);


VIMRuntime::make_get_set('HostSystemResourceInfo', 'key', 'config', 'child');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostSystemResourceInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostSystemResourceInfo', 'HostSystemResourceInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostSystemResourceInfo', 'HostSystemResourceInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostTargetTransport;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('HostTargetTransport');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostParallelScsiTargetTransport;
our @ISA = qw(HostTargetTransport);

our @property_list = (
);


VIMRuntime::make_get_set('HostParallelScsiTargetTransport');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostBlockAdapterTargetTransport;
our @ISA = qw(HostTargetTransport);

our @property_list = (
);


VIMRuntime::make_get_set('HostBlockAdapterTargetTransport');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostFibreChannelTargetTransport;
our @ISA = qw(HostTargetTransport);

our @property_list = (
   ['portWorldWideName', undef, undef, 1],
   ['nodeWorldWideName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostFibreChannelTargetTransport', 'portWorldWideName', 'nodeWorldWideName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostInternetScsiTargetTransport;
our @ISA = qw(HostTargetTransport);

our @property_list = (
   ['iScsiName', undef, undef, 1],
   ['iScsiAlias', undef, undef, 1],
   ['address', undef, 1, 0],
);


VIMRuntime::make_get_set('HostInternetScsiTargetTransport', 'iScsiName', 'iScsiAlias', 'address');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vmotionNicKey', undef, undef, 0],
   ['enabled', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostVMotionConfig', 'vmotionNicKey', 'enabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['netConfig', 'HostVMotionNetConfig', undef, 0],
   ['ipConfig', 'HostIpConfig', undef, 0],
);


VIMRuntime::make_get_set('HostVMotionInfo', 'netConfig', 'ipConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionManagerSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['migrationId', undef, undef, 1],
   ['srcIp', undef, undef, 1],
   ['dstIp', undef, undef, 1],
   ['srcUuid', undef, undef, 1],
   ['dstUuid', undef, undef, 1],
   ['priority', 'VirtualMachineMovePriority', undef, 1],
);


VIMRuntime::make_get_set('HostVMotionManagerSpec', 'migrationId', 'srcIp', 'dstIp', 'srcUuid', 'dstUuid', 'priority');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionManagerDestinationState;
our @ISA = qw(DynamicData);

our @property_list = (
   ['dstId', undef, undef, 1],
   ['dstTask', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('HostVMotionManagerDestinationState', 'dstId', 'dstTask');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionManagerReparentSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['busNumber', undef, undef, 1],
   ['unitNumber', undef, undef, 1],
   ['filename', undef, undef, 1],
);


VIMRuntime::make_get_set('HostVMotionManagerReparentSpec', 'busNumber', 'unitNumber', 'filename');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostVMotionManagerReparentSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostVMotionManagerReparentSpec', 'HostVMotionManagerReparentSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostVMotionManagerReparentSpec', 'HostVMotionManagerReparentSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVMotionNetConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['candidateVnic', 'HostVirtualNic', 1, 0],
   ['selectedVnic', undef, undef, 0],
);


VIMRuntime::make_get_set('HostVMotionNetConfig', 'candidateVnic', 'selectedVnic');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualNicSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['ip', 'HostIpConfig', undef, 0],
   ['mac', undef, undef, 0],
);


VIMRuntime::make_get_set('HostVirtualNicSpec', 'ip', 'mac');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualNicConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['changeOperation', undef, undef, 0],
   ['device', undef, undef, 0],
   ['portgroup', undef, undef, 1],
   ['spec', 'HostVirtualNicSpec', undef, 0],
);


VIMRuntime::make_get_set('HostVirtualNicConfig', 'changeOperation', 'device', 'portgroup', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostVirtualNicConfig;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostVirtualNicConfig', 'HostVirtualNicConfig', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostVirtualNicConfig', 'HostVirtualNicConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualNic;
our @ISA = qw(DynamicData);

our @property_list = (
   ['device', undef, undef, 1],
   ['key', undef, undef, 1],
   ['portgroup', undef, undef, 1],
   ['spec', 'HostVirtualNicSpec', undef, 1],
   ['port', undef, undef, 0],
);


VIMRuntime::make_get_set('HostVirtualNic', 'device', 'key', 'portgroup', 'spec', 'port');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostVirtualNic;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostVirtualNic', 'HostVirtualNic', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostVirtualNic', 'HostVirtualNic');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchBridge;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('HostVirtualSwitchBridge');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchAutoBridge;
our @ISA = qw(HostVirtualSwitchBridge);

our @property_list = (
);


VIMRuntime::make_get_set('HostVirtualSwitchAutoBridge');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchSimpleBridge;
our @ISA = qw(HostVirtualSwitchBridge);

our @property_list = (
   ['nicDevice', undef, undef, 1],
);


VIMRuntime::make_get_set('HostVirtualSwitchSimpleBridge', 'nicDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchBondBridge;
our @ISA = qw(HostVirtualSwitchBridge);

our @property_list = (
   ['nicDevice', undef, 1, 1],
   ['beacon', 'HostVirtualSwitchBeaconConfig', undef, 0],
);


VIMRuntime::make_get_set('HostVirtualSwitchBondBridge', 'nicDevice', 'beacon');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchBeaconConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['interval', undef, undef, 1],
);


VIMRuntime::make_get_set('HostVirtualSwitchBeaconConfig', 'interval');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['numPorts', undef, undef, 1],
   ['bridge', 'HostVirtualSwitchBridge', undef, 0],
   ['policy', 'HostNetworkPolicy', undef, 0],
);


VIMRuntime::make_get_set('HostVirtualSwitchSpec', 'numPorts', 'bridge', 'policy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitchConfig;
our @ISA = qw(DynamicData);

our @property_list = (
   ['changeOperation', undef, undef, 0],
   ['name', undef, undef, 1],
   ['spec', 'HostVirtualSwitchSpec', undef, 0],
);


VIMRuntime::make_get_set('HostVirtualSwitchConfig', 'changeOperation', 'name', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostVirtualSwitchConfig;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostVirtualSwitchConfig', 'HostVirtualSwitchConfig', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostVirtualSwitchConfig', 'HostVirtualSwitchConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVirtualSwitch;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['key', undef, undef, 1],
   ['numPorts', undef, undef, 1],
   ['numPortsAvailable', undef, undef, 1],
   ['portgroup', undef, 1, 0],
   ['pnic', undef, 1, 0],
   ['spec', 'HostVirtualSwitchSpec', undef, 1],
);


VIMRuntime::make_get_set('HostVirtualSwitch', 'name', 'key', 'numPorts', 'numPortsAvailable', 'portgroup', 'pnic', 'spec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostVirtualSwitch;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostVirtualSwitch', 'HostVirtualSwitch', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostVirtualSwitch', 'HostVirtualSwitch');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVmfsSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['extent', 'HostScsiDiskPartition', undef, 1],
   ['blockSizeMb', undef, undef, 0],
   ['majorVersion', undef, undef, 1],
   ['volumeName', undef, undef, 1],
);


VIMRuntime::make_get_set('HostVmfsSpec', 'extent', 'blockSizeMb', 'majorVersion', 'volumeName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostVmfsVolume;
our @ISA = qw(HostFileSystemVolume);

our @property_list = (
   ['blockSizeMb', undef, undef, 1],
   ['maxBlocks', undef, undef, 1],
   ['majorVersion', undef, undef, 1],
   ['version', undef, undef, 1],
   ['uuid', undef, undef, 1],
   ['extent', 'HostScsiDiskPartition', 1, 1],
   ['vmfsUpgradable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('HostVmfsVolume', 'blockSizeMb', 'maxBlocks', 'majorVersion', 'version', 'uuid', 'extent', 'vmfsUpgradable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayUpdateSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['operation', 'ArrayUpdateOperation', undef, 1],
   ['removeKey', 'anyType', undef, 0],
);


VIMRuntime::make_get_set('ArrayUpdateSpec', 'operation', 'removeKey');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package BoolOption;
our @ISA = qw(OptionType);

our @property_list = (
   ['supported', 'boolean', undef, 1],
   ['defaultValue', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('BoolOption', 'supported', 'defaultValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ChoiceOption;
our @ISA = qw(OptionType);

our @property_list = (
   ['choiceInfo', 'ElementDescription', 1, 1],
   ['defaultIndex', undef, undef, 0],
);


VIMRuntime::make_get_set('ChoiceOption', 'choiceInfo', 'defaultIndex');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package FloatOption;
our @ISA = qw(OptionType);

our @property_list = (
   ['min', undef, undef, 1],
   ['max', undef, undef, 1],
   ['defaultValue', undef, undef, 1],
);


VIMRuntime::make_get_set('FloatOption', 'min', 'max', 'defaultValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package IntOption;
our @ISA = qw(OptionType);

our @property_list = (
   ['min', undef, undef, 1],
   ['max', undef, undef, 1],
   ['defaultValue', undef, undef, 1],
);


VIMRuntime::make_get_set('IntOption', 'min', 'max', 'defaultValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package LongOption;
our @ISA = qw(OptionType);

our @property_list = (
   ['min', undef, undef, 1],
   ['max', undef, undef, 1],
   ['defaultValue', undef, undef, 1],
);


VIMRuntime::make_get_set('LongOption', 'min', 'max', 'defaultValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package OptionDef;
our @ISA = qw(ElementDescription);

our @property_list = (
   ['optionType', 'OptionType', undef, 1],
);


VIMRuntime::make_get_set('OptionDef', 'optionType');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfOptionDef;
our @ISA = qw(ComplexType);

our @property_list = (
   ['OptionDef', 'OptionDef', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfOptionDef', 'OptionDef');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package OptionType;
our @ISA = qw(DynamicData);

our @property_list = (
   ['valueIsReadonly', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('OptionType', 'valueIsReadonly');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package OptionValue;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['value', 'anyType', undef, 0],
);


VIMRuntime::make_get_set('OptionValue', 'key', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfOptionValue;
our @ISA = qw(ComplexType);

our @property_list = (
   ['OptionValue', 'OptionValue', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfOptionValue', 'OptionValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package StringOption;
our @ISA = qw(OptionType);

our @property_list = (
   ['defaultValue', undef, undef, 1],
   ['validCharacters', undef, undef, 0],
);


VIMRuntime::make_get_set('StringOption', 'defaultValue', 'validCharacters');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskDetail;
our @ISA = qw(TypeDescription);

our @property_list = (
   ['frequency', undef, undef, 1],
);


VIMRuntime::make_get_set('ScheduledTaskDetail', 'frequency');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfScheduledTaskDetail;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ScheduledTaskDetail', 'ScheduledTaskDetail', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfScheduledTaskDetail', 'ScheduledTaskDetail');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskDescription;
our @ISA = qw(DynamicData);

our @property_list = (
   ['action', 'TypeDescription', 1, 1],
   ['schedulerInfo', 'ScheduledTaskDetail', 1, 1],
   ['state', 'ElementDescription', 1, 1],
   ['dayOfWeek', 'ElementDescription', 1, 1],
   ['weekOfMonth', 'ElementDescription', 1, 1],
);


VIMRuntime::make_get_set('ScheduledTaskDescription', 'action', 'schedulerInfo', 'state', 'dayOfWeek', 'weekOfMonth');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskInfo;
our @ISA = qw(ScheduledTaskSpec);

our @property_list = (
   ['scheduledTask', 'ManagedObjectReference', undef, 1],
   ['entity', 'ManagedObjectReference', undef, 1],
   ['lastModifiedTime', undef, undef, 1],
   ['lastModifiedUser', undef, undef, 1],
   ['nextRunTime', undef, undef, 0],
   ['prevRunTime', undef, undef, 0],
   ['state', 'TaskInfoState', undef, 1],
   ['error', 'LocalizedMethodFault', undef, 0],
   ['result', 'anyType', undef, 0],
   ['progress', undef, undef, 0],
   ['activeTask', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('ScheduledTaskInfo', 'scheduledTask', 'entity', 'lastModifiedTime', 'lastModifiedUser', 'nextRunTime', 'prevRunTime', 'state', 'error', 'result', 'progress', 'activeTask');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package TaskScheduler;
our @ISA = qw(DynamicData);

our @property_list = (
   ['activeTime', undef, undef, 0],
   ['expireTime', undef, undef, 0],
);


VIMRuntime::make_get_set('TaskScheduler', 'activeTime', 'expireTime');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package AfterStartupTaskScheduler;
our @ISA = qw(TaskScheduler);

our @property_list = (
   ['minute', undef, undef, 1],
);


VIMRuntime::make_get_set('AfterStartupTaskScheduler', 'minute');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package OnceTaskScheduler;
our @ISA = qw(TaskScheduler);

our @property_list = (
   ['runAt', undef, undef, 0],
);


VIMRuntime::make_get_set('OnceTaskScheduler', 'runAt');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package RecurrentTaskScheduler;
our @ISA = qw(TaskScheduler);

our @property_list = (
   ['interval', undef, undef, 1],
);


VIMRuntime::make_get_set('RecurrentTaskScheduler', 'interval');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HourlyTaskScheduler;
our @ISA = qw(RecurrentTaskScheduler);

our @property_list = (
   ['minute', undef, undef, 1],
);


VIMRuntime::make_get_set('HourlyTaskScheduler', 'minute');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DailyTaskScheduler;
our @ISA = qw(HourlyTaskScheduler);

our @property_list = (
   ['hour', undef, undef, 1],
);


VIMRuntime::make_get_set('DailyTaskScheduler', 'hour');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package WeeklyTaskScheduler;
our @ISA = qw(DailyTaskScheduler);

our @property_list = (
   ['sunday', 'boolean', undef, 1],
   ['monday', 'boolean', undef, 1],
   ['tuesday', 'boolean', undef, 1],
   ['wednesday', 'boolean', undef, 1],
   ['thursday', 'boolean', undef, 1],
   ['friday', 'boolean', undef, 1],
   ['saturday', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('WeeklyTaskScheduler', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MonthlyTaskScheduler;
our @ISA = qw(DailyTaskScheduler);

our @property_list = (
);


VIMRuntime::make_get_set('MonthlyTaskScheduler');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MonthlyByDayTaskScheduler;
our @ISA = qw(MonthlyTaskScheduler);

our @property_list = (
   ['day', undef, undef, 1],
);


VIMRuntime::make_get_set('MonthlyByDayTaskScheduler', 'day');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package MonthlyByWeekdayTaskScheduler;
our @ISA = qw(MonthlyTaskScheduler);

our @property_list = (
   ['offset', 'WeekOfMonth', undef, 1],
   ['weekday', 'DayOfWeek', undef, 1],
);


VIMRuntime::make_get_set('MonthlyByWeekdayTaskScheduler', 'offset', 'weekday');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ScheduledTaskSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['description', undef, undef, 1],
   ['enabled', 'boolean', undef, 1],
   ['scheduler', 'TaskScheduler', undef, 1],
   ['action', 'Action', undef, 1],
   ['notification', undef, undef, 0],
);


VIMRuntime::make_get_set('ScheduledTaskSpec', 'name', 'description', 'enabled', 'scheduler', 'action', 'notification');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineAffinityInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['affinitySet', undef, 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineAffinityInfo', 'affinitySet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineCapability;
our @ISA = qw(DynamicData);

our @property_list = (
   ['snapshotOperationsSupported', 'boolean', undef, 1],
   ['multipleSnapshotsSupported', 'boolean', undef, 1],
   ['snapshotConfigSupported', 'boolean', undef, 1],
   ['poweredOffSnapshotsSupported', 'boolean', undef, 1],
   ['memorySnapshotsSupported', 'boolean', undef, 1],
   ['revertToSnapshotSupported', 'boolean', undef, 1],
   ['quiescedSnapshotsSupported', 'boolean', undef, 1],
   ['consolePreferencesSupported', 'boolean', undef, 1],
   ['cpuFeatureMaskSupported', 'boolean', undef, 1],
   ['s1AcpiManagementSupported', 'boolean', undef, 1],
   ['settingScreenResolutionSupported', 'boolean', undef, 1],
   ['toolsAutoUpdateSupported', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineCapability', 'snapshotOperationsSupported', 'multipleSnapshotsSupported', 'snapshotConfigSupported', 'poweredOffSnapshotsSupported', 'memorySnapshotsSupported', 'revertToSnapshotSupported', 'quiescedSnapshotsSupported', 'consolePreferencesSupported', 'cpuFeatureMaskSupported', 's1AcpiManagementSupported', 'settingScreenResolutionSupported', 'toolsAutoUpdateSupported');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineCdromInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualMachineCdromInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineCdromInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineCdromInfo', 'VirtualMachineCdromInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineCdromInfo', 'VirtualMachineCdromInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineCloneSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['location', 'VirtualMachineRelocateSpec', undef, 1],
   ['template', 'boolean', undef, 1],
   ['config', 'VirtualMachineConfigSpec', undef, 0],
   ['customization', 'CustomizationSpec', undef, 0],
   ['powerOn', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineCloneSpec', 'location', 'template', 'config', 'customization', 'powerOn');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConfigInfoDatastoreUrlPair;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['url', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineConfigInfoDatastoreUrlPair', 'name', 'url');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineConfigInfoDatastoreUrlPair;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineConfigInfoDatastoreUrlPair', 'VirtualMachineConfigInfoDatastoreUrlPair', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineConfigInfoDatastoreUrlPair', 'VirtualMachineConfigInfoDatastoreUrlPair');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['changeVersion', undef, undef, 1],
   ['modified', undef, undef, 1],
   ['name', undef, undef, 1],
   ['guestFullName', undef, undef, 1],
   ['version', undef, undef, 1],
   ['uuid', undef, undef, 1],
   ['locationId', undef, undef, 0],
   ['template', 'boolean', undef, 1],
   ['guestId', undef, undef, 1],
   ['annotation', undef, undef, 0],
   ['files', 'VirtualMachineFileInfo', undef, 1],
   ['tools', 'ToolsConfigInfo', undef, 0],
   ['flags', 'VirtualMachineFlagInfo', undef, 1],
   ['consolePreferences', 'VirtualMachineConsolePreferences', undef, 0],
   ['defaultPowerOps', 'VirtualMachineDefaultPowerOpInfo', undef, 1],
   ['hardware', 'VirtualHardware', undef, 1],
   ['cpuAllocation', 'ResourceAllocationInfo', undef, 0],
   ['memoryAllocation', 'ResourceAllocationInfo', undef, 0],
   ['cpuAffinity', 'VirtualMachineAffinityInfo', undef, 0],
   ['memoryAffinity', 'VirtualMachineAffinityInfo', undef, 0],
   ['networkShaper', 'VirtualMachineNetworkShaperInfo', undef, 0],
   ['extraConfig', 'OptionValue', 1, 0],
   ['cpuFeatureMask', 'HostCpuIdInfo', 1, 0],
   ['datastoreUrl', 'VirtualMachineConfigInfoDatastoreUrlPair', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineConfigInfo', 'changeVersion', 'modified', 'name', 'guestFullName', 'version', 'uuid', 'locationId', 'template', 'guestId', 'annotation', 'files', 'tools', 'flags', 'consolePreferences', 'defaultPowerOps', 'hardware', 'cpuAllocation', 'memoryAllocation', 'cpuAffinity', 'memoryAffinity', 'networkShaper', 'extraConfig', 'cpuFeatureMask', 'datastoreUrl');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConfigOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['version', undef, undef, 1],
   ['description', undef, undef, 1],
   ['guestOSDescriptor', 'GuestOsDescriptor', 1, 1],
   ['guestOSDefaultIndex', undef, undef, 1],
   ['hardwareOptions', 'VirtualHardwareOption', undef, 1],
   ['capabilities', 'VirtualMachineCapability', undef, 1],
   ['datastore', 'DatastoreOption', undef, 1],
   ['defaultDevice', 'VirtualDevice', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineConfigOption', 'version', 'description', 'guestOSDescriptor', 'guestOSDefaultIndex', 'hardwareOptions', 'capabilities', 'datastore', 'defaultDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConfigOptionDescriptor;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['description', undef, undef, 0],
   ['host', 'ManagedObjectReference', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineConfigOptionDescriptor', 'key', 'description', 'host');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineConfigOptionDescriptor;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineConfigOptionDescriptor', 'VirtualMachineConfigOptionDescriptor', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineConfigOptionDescriptor', 'VirtualMachineConfigOptionDescriptor');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineCpuIdInfoSpec;
our @ISA = qw(ArrayUpdateSpec);

our @property_list = (
   ['info', 'HostCpuIdInfo', undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineCpuIdInfoSpec', 'info');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineCpuIdInfoSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineCpuIdInfoSpec', 'VirtualMachineCpuIdInfoSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineCpuIdInfoSpec', 'VirtualMachineCpuIdInfoSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConfigSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['changeVersion', undef, undef, 0],
   ['name', undef, undef, 0],
   ['version', undef, undef, 0],
   ['uuid', undef, undef, 0],
   ['locationId', undef, undef, 0],
   ['guestId', undef, undef, 0],
   ['annotation', undef, undef, 0],
   ['files', 'VirtualMachineFileInfo', undef, 0],
   ['tools', 'ToolsConfigInfo', undef, 0],
   ['flags', 'VirtualMachineFlagInfo', undef, 0],
   ['consolePreferences', 'VirtualMachineConsolePreferences', undef, 0],
   ['powerOpInfo', 'VirtualMachineDefaultPowerOpInfo', undef, 0],
   ['numCPUs', undef, undef, 0],
   ['memoryMB', undef, undef, 0],
   ['deviceChange', 'VirtualDeviceConfigSpec', 1, 0],
   ['cpuAllocation', 'ResourceAllocationInfo', undef, 0],
   ['memoryAllocation', 'ResourceAllocationInfo', undef, 0],
   ['cpuAffinity', 'VirtualMachineAffinityInfo', undef, 0],
   ['memoryAffinity', 'VirtualMachineAffinityInfo', undef, 0],
   ['networkShaper', 'VirtualMachineNetworkShaperInfo', undef, 0],
   ['cpuFeatureMask', 'VirtualMachineCpuIdInfoSpec', 1, 0],
   ['extraConfig', 'OptionValue', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineConfigSpec', 'changeVersion', 'name', 'version', 'uuid', 'locationId', 'guestId', 'annotation', 'files', 'tools', 'flags', 'consolePreferences', 'powerOpInfo', 'numCPUs', 'memoryMB', 'deviceChange', 'cpuAllocation', 'memoryAllocation', 'cpuAffinity', 'memoryAffinity', 'networkShaper', 'cpuFeatureMask', 'extraConfig');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ConfigTarget;
our @ISA = qw(DynamicData);

our @property_list = (
   ['numCpus', undef, undef, 1],
   ['numCpuCores', undef, undef, 1],
   ['numNumaNodes', undef, undef, 1],
   ['datastore', 'VirtualMachineDatastoreInfo', 1, 0],
   ['network', 'VirtualMachineNetworkInfo', 1, 0],
   ['cdRom', 'VirtualMachineCdromInfo', 1, 0],
   ['serial', 'VirtualMachineSerialInfo', 1, 0],
   ['parallel', 'VirtualMachineParallelInfo', 1, 0],
   ['floppy', 'VirtualMachineFloppyInfo', 1, 0],
   ['legacyNetworkInfo', 'VirtualMachineLegacyNetworkSwitchInfo', 1, 0],
   ['scsiPassthrough', 'VirtualMachineScsiPassthroughInfo', 1, 0],
   ['scsiDisk', 'VirtualMachineScsiDiskDeviceInfo', 1, 0],
   ['ideDisk', 'VirtualMachineIdeDiskDeviceInfo', 1, 0],
   ['maxMemMBOptimalPerf', undef, undef, 1],
   ['resourcePool', 'ResourcePoolRuntimeInfo', undef, 0],
   ['autoVmotion', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('ConfigTarget', 'numCpus', 'numCpuCores', 'numNumaNodes', 'datastore', 'network', 'cdRom', 'serial', 'parallel', 'floppy', 'legacyNetworkInfo', 'scsiPassthrough', 'scsiDisk', 'ideDisk', 'maxMemMBOptimalPerf', 'resourcePool', 'autoVmotion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConsolePreferences;
our @ISA = qw(DynamicData);

our @property_list = (
   ['powerOnWhenOpened', 'boolean', undef, 0],
   ['enterFullScreenOnPowerOn', 'boolean', undef, 0],
   ['closeOnPowerOffOrSuspend', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineConsolePreferences', 'powerOnWhenOpened', 'enterFullScreenOnPowerOn', 'closeOnPowerOffOrSuspend');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineDatastoreInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
   ['datastore', 'DatastoreSummary', undef, 1],
   ['capability', 'DatastoreCapability', undef, 1],
   ['maxFileSize', undef, undef, 1],
   ['mode', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineDatastoreInfo', 'datastore', 'capability', 'maxFileSize', 'mode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineDatastoreInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineDatastoreInfo', 'VirtualMachineDatastoreInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineDatastoreInfo', 'VirtualMachineDatastoreInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineDatastoreVolumeOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['fileSystemType', undef, undef, 1],
   ['majorVersion', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineDatastoreVolumeOption', 'fileSystemType', 'majorVersion');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineDatastoreVolumeOption;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineDatastoreVolumeOption', 'VirtualMachineDatastoreVolumeOption', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineDatastoreVolumeOption', 'VirtualMachineDatastoreVolumeOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package DatastoreOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['unsupportedVolumes', 'VirtualMachineDatastoreVolumeOption', 1, 0],
);


VIMRuntime::make_get_set('DatastoreOption', 'unsupportedVolumes');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineDefaultPowerOpInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['powerOffType', undef, undef, 0],
   ['suspendType', undef, undef, 0],
   ['resetType', undef, undef, 0],
   ['defaultPowerOffType', undef, undef, 0],
   ['defaultSuspendType', undef, undef, 0],
   ['defaultResetType', undef, undef, 0],
   ['standbyAction', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineDefaultPowerOpInfo', 'powerOffType', 'suspendType', 'resetType', 'defaultPowerOffType', 'defaultSuspendType', 'defaultResetType', 'standbyAction');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineDiskDeviceInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
   ['capacity', undef, undef, 0],
   ['vm', 'ManagedObjectReference', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineDiskDeviceInfo', 'capacity', 'vm');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineFileInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vmPathName', undef, undef, 0],
   ['snapshotDirectory', undef, undef, 0],
   ['suspendDirectory', undef, undef, 0],
   ['logDirectory', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineFileInfo', 'vmPathName', 'snapshotDirectory', 'suspendDirectory', 'logDirectory');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineFileLayoutDiskLayout;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['diskFile', undef, 1, 1],
);


VIMRuntime::make_get_set('VirtualMachineFileLayoutDiskLayout', 'key', 'diskFile');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineFileLayoutDiskLayout;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineFileLayoutDiskLayout', 'VirtualMachineFileLayoutDiskLayout', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineFileLayoutDiskLayout', 'VirtualMachineFileLayoutDiskLayout');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineFileLayoutSnapshotLayout;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', 'ManagedObjectReference', undef, 1],
   ['snapshotFile', undef, 1, 1],
);


VIMRuntime::make_get_set('VirtualMachineFileLayoutSnapshotLayout', 'key', 'snapshotFile');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineFileLayoutSnapshotLayout;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineFileLayoutSnapshotLayout', 'VirtualMachineFileLayoutSnapshotLayout', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineFileLayoutSnapshotLayout', 'VirtualMachineFileLayoutSnapshotLayout');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineFileLayout;
our @ISA = qw(DynamicData);

our @property_list = (
   ['configFile', undef, 1, 0],
   ['logFile', undef, 1, 0],
   ['disk', 'VirtualMachineFileLayoutDiskLayout', 1, 0],
   ['snapshot', 'VirtualMachineFileLayoutSnapshotLayout', 1, 0],
   ['swapFile', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineFileLayout', 'configFile', 'logFile', 'disk', 'snapshot', 'swapFile');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineFlagInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['disableAcceleration', 'boolean', undef, 0],
   ['enableLogging', 'boolean', undef, 0],
   ['useToe', 'boolean', undef, 0],
   ['runWithDebugInfo', 'boolean', undef, 0],
   ['htSharing', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineFlagInfo', 'disableAcceleration', 'enableLogging', 'useToe', 'runWithDebugInfo', 'htSharing');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineFloppyInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualMachineFloppyInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineFloppyInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineFloppyInfo', 'VirtualMachineFloppyInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineFloppyInfo', 'VirtualMachineFloppyInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GuestDiskInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['diskPath', undef, undef, 0],
   ['capacity', undef, undef, 0],
   ['freeSpace', undef, undef, 0],
);


VIMRuntime::make_get_set('GuestDiskInfo', 'diskPath', 'capacity', 'freeSpace');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfGuestDiskInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['GuestDiskInfo', 'GuestDiskInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfGuestDiskInfo', 'GuestDiskInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GuestNicInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['network', undef, undef, 0],
   ['ipAddress', undef, 1, 0],
   ['macAddress', undef, undef, 0],
   ['connected', 'boolean', undef, 1],
   ['deviceConfigId', undef, undef, 1],
);


VIMRuntime::make_get_set('GuestNicInfo', 'network', 'ipAddress', 'macAddress', 'connected', 'deviceConfigId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfGuestNicInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['GuestNicInfo', 'GuestNicInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfGuestNicInfo', 'GuestNicInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GuestScreenInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['width', undef, undef, 1],
   ['height', undef, undef, 1],
);


VIMRuntime::make_get_set('GuestScreenInfo', 'width', 'height');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GuestInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['toolsStatus', 'VirtualMachineToolsStatus', undef, 0],
   ['toolsVersion', undef, undef, 0],
   ['guestId', undef, undef, 0],
   ['guestFamily', undef, undef, 0],
   ['guestFullName', undef, undef, 0],
   ['hostName', undef, undef, 0],
   ['ipAddress', undef, undef, 0],
   ['net', 'GuestNicInfo', 1, 0],
   ['disk', 'GuestDiskInfo', 1, 0],
   ['screen', 'GuestScreenInfo', undef, 0],
   ['guestState', undef, undef, 1],
);


VIMRuntime::make_get_set('GuestInfo', 'toolsStatus', 'toolsVersion', 'guestId', 'guestFamily', 'guestFullName', 'hostName', 'ipAddress', 'net', 'disk', 'screen', 'guestState');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package GuestOsDescriptor;
our @ISA = qw(DynamicData);

our @property_list = (
   ['id', undef, undef, 1],
   ['family', undef, undef, 1],
   ['fullName', undef, undef, 1],
   ['supportedMaxCPUs', undef, undef, 1],
   ['supportedMinMemMB', undef, undef, 1],
   ['supportedMaxMemMB', undef, undef, 1],
   ['recommendedMemMB', undef, undef, 1],
   ['recommendedColorDepth', undef, undef, 1],
   ['supportedDiskControllerList', undef, 1, 1],
   ['recommendedSCSIController', undef, undef, 0],
   ['recommendedDiskController', undef, undef, 1],
   ['supportedNumDisks', undef, undef, 1],
   ['recommendedDiskSizeMB', undef, undef, 1],
   ['supportedEthernetCard', undef, 1, 1],
   ['recommendedEthernetCard', undef, undef, 0],
   ['supportsSlaveDisk', 'boolean', undef, 0],
   ['cpuFeatureMask', 'HostCpuIdInfo', 1, 0],
   ['supportsWakeOnLan', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('GuestOsDescriptor', 'id', 'family', 'fullName', 'supportedMaxCPUs', 'supportedMinMemMB', 'supportedMaxMemMB', 'recommendedMemMB', 'recommendedColorDepth', 'supportedDiskControllerList', 'recommendedSCSIController', 'recommendedDiskController', 'supportedNumDisks', 'recommendedDiskSizeMB', 'supportedEthernetCard', 'recommendedEthernetCard', 'supportsSlaveDisk', 'cpuFeatureMask', 'supportsWakeOnLan');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfGuestOsDescriptor;
our @ISA = qw(ComplexType);

our @property_list = (
   ['GuestOsDescriptor', 'GuestOsDescriptor', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfGuestOsDescriptor', 'GuestOsDescriptor');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineIdeDiskDevicePartitionInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['id', undef, undef, 1],
   ['capacity', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineIdeDiskDevicePartitionInfo', 'id', 'capacity');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineIdeDiskDevicePartitionInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineIdeDiskDevicePartitionInfo', 'VirtualMachineIdeDiskDevicePartitionInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineIdeDiskDevicePartitionInfo', 'VirtualMachineIdeDiskDevicePartitionInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineIdeDiskDeviceInfo;
our @ISA = qw(VirtualMachineDiskDeviceInfo);

our @property_list = (
   ['partitionTable', 'VirtualMachineIdeDiskDevicePartitionInfo', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineIdeDiskDeviceInfo', 'partitionTable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineIdeDiskDeviceInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineIdeDiskDeviceInfo', 'VirtualMachineIdeDiskDeviceInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineIdeDiskDeviceInfo', 'VirtualMachineIdeDiskDeviceInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineLegacyNetworkSwitchInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineLegacyNetworkSwitchInfo', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineLegacyNetworkSwitchInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineLegacyNetworkSwitchInfo', 'VirtualMachineLegacyNetworkSwitchInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineLegacyNetworkSwitchInfo', 'VirtualMachineLegacyNetworkSwitchInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineNetworkInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
   ['network', 'NetworkSummary', undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineNetworkInfo', 'network');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineNetworkInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineNetworkInfo', 'VirtualMachineNetworkInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineNetworkInfo', 'VirtualMachineNetworkInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineNetworkShaperInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['enabled', 'boolean', undef, 0],
   ['peakBps', undef, undef, 0],
   ['averageBps', undef, undef, 0],
   ['burstSize', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineNetworkShaperInfo', 'enabled', 'peakBps', 'averageBps', 'burstSize');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineParallelInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualMachineParallelInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineParallelInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineParallelInfo', 'VirtualMachineParallelInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineParallelInfo', 'VirtualMachineParallelInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineQuestionInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['id', undef, undef, 1],
   ['text', undef, undef, 1],
   ['choice', 'ChoiceOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineQuestionInfo', 'id', 'text', 'choice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineRelocateSpecDiskLocator;
our @ISA = qw(DynamicData);

our @property_list = (
   ['diskId', undef, undef, 1],
   ['datastore', 'ManagedObjectReference', undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineRelocateSpecDiskLocator', 'diskId', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineRelocateSpecDiskLocator;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineRelocateSpecDiskLocator', 'VirtualMachineRelocateSpecDiskLocator', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineRelocateSpecDiskLocator', 'VirtualMachineRelocateSpecDiskLocator');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineRelocateSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['datastore', 'ManagedObjectReference', undef, 0],
   ['pool', 'ManagedObjectReference', undef, 0],
   ['host', 'ManagedObjectReference', undef, 0],
   ['disk', 'VirtualMachineRelocateSpecDiskLocator', 1, 0],
   ['transform', 'VirtualMachineRelocateTransformation', undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineRelocateSpec', 'datastore', 'pool', 'host', 'disk', 'transform');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineRuntimeInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['host', 'ManagedObjectReference', undef, 0],
   ['connectionState', 'VirtualMachineConnectionState', undef, 1],
   ['powerState', 'VirtualMachinePowerState', undef, 1],
   ['toolsInstallerMounted', 'boolean', undef, 1],
   ['suspendTime', undef, undef, 0],
   ['bootTime', undef, undef, 0],
   ['suspendInterval', undef, undef, 0],
   ['question', 'VirtualMachineQuestionInfo', undef, 0],
   ['memoryOverhead', undef, undef, 0],
   ['maxCpuUsage', undef, undef, 0],
   ['maxMemoryUsage', undef, undef, 0],
   ['numMksConnections', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineRuntimeInfo', 'host', 'connectionState', 'powerState', 'toolsInstallerMounted', 'suspendTime', 'bootTime', 'suspendInterval', 'question', 'memoryOverhead', 'maxCpuUsage', 'maxMemoryUsage', 'numMksConnections');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineScsiDiskDeviceInfo;
our @ISA = qw(VirtualMachineDiskDeviceInfo);

our @property_list = (
   ['disk', 'HostScsiDisk', undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineScsiDiskDeviceInfo', 'disk');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineScsiDiskDeviceInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineScsiDiskDeviceInfo', 'VirtualMachineScsiDiskDeviceInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineScsiDiskDeviceInfo', 'VirtualMachineScsiDiskDeviceInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineScsiPassthroughInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
   ['scsiClass', undef, undef, 1],
   ['vendor', undef, undef, 1],
   ['physicalUnitNumber', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualMachineScsiPassthroughInfo', 'scsiClass', 'vendor', 'physicalUnitNumber');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineScsiPassthroughInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineScsiPassthroughInfo', 'VirtualMachineScsiPassthroughInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineScsiPassthroughInfo', 'VirtualMachineScsiPassthroughInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineSerialInfo;
our @ISA = qw(VirtualMachineTargetInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualMachineSerialInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineSerialInfo;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineSerialInfo', 'VirtualMachineSerialInfo', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineSerialInfo', 'VirtualMachineSerialInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineSnapshotInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['currentSnapshot', 'ManagedObjectReference', undef, 0],
   ['rootSnapshotList', 'VirtualMachineSnapshotTree', 1, 1],
);


VIMRuntime::make_get_set('VirtualMachineSnapshotInfo', 'currentSnapshot', 'rootSnapshotList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineSnapshotTree;
our @ISA = qw(DynamicData);

our @property_list = (
   ['snapshot', 'ManagedObjectReference', undef, 1],
   ['vm', 'ManagedObjectReference', undef, 1],
   ['name', undef, undef, 1],
   ['description', undef, undef, 1],
   ['createTime', undef, undef, 1],
   ['state', 'VirtualMachinePowerState', undef, 1],
   ['quiesced', 'boolean', undef, 1],
   ['childSnapshotList', 'VirtualMachineSnapshotTree', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineSnapshotTree', 'snapshot', 'vm', 'name', 'description', 'createTime', 'state', 'quiesced', 'childSnapshotList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineSnapshotTree;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineSnapshotTree', 'VirtualMachineSnapshotTree', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineSnapshotTree', 'VirtualMachineSnapshotTree');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineConfigSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['template', 'boolean', undef, 1],
   ['vmPathName', undef, undef, 1],
   ['memorySizeMB', undef, undef, 0],
   ['cpuReservation', undef, undef, 0],
   ['memoryReservation', undef, undef, 0],
   ['numCpu', undef, undef, 0],
   ['numEthernetCards', undef, undef, 0],
   ['numVirtualDisks', undef, undef, 0],
   ['uuid', undef, undef, 0],
   ['guestId', undef, undef, 0],
   ['guestFullName', undef, undef, 0],
   ['annotation', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineConfigSummary', 'name', 'template', 'vmPathName', 'memorySizeMB', 'cpuReservation', 'memoryReservation', 'numCpu', 'numEthernetCards', 'numVirtualDisks', 'uuid', 'guestId', 'guestFullName', 'annotation');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineQuickStats;
our @ISA = qw(DynamicData);

our @property_list = (
   ['overallCpuUsage', undef, undef, 0],
   ['guestMemoryUsage', undef, undef, 0],
   ['hostMemoryUsage', undef, undef, 0],
   ['guestHeartbeatStatus', 'ManagedEntityStatus', undef, 1],
   ['distributedCpuEntitlement', undef, undef, 0],
   ['distributedMemoryEntitlement', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineQuickStats', 'overallCpuUsage', 'guestMemoryUsage', 'hostMemoryUsage', 'guestHeartbeatStatus', 'distributedCpuEntitlement', 'distributedMemoryEntitlement');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineGuestSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['guestId', undef, undef, 0],
   ['guestFullName', undef, undef, 0],
   ['toolsStatus', 'VirtualMachineToolsStatus', undef, 0],
   ['hostName', undef, undef, 0],
   ['ipAddress', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineGuestSummary', 'guestId', 'guestFullName', 'toolsStatus', 'hostName', 'ipAddress');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineSummary;
our @ISA = qw(DynamicData);

our @property_list = (
   ['vm', 'ManagedObjectReference', undef, 0],
   ['runtime', 'VirtualMachineRuntimeInfo', undef, 1],
   ['guest', 'VirtualMachineGuestSummary', undef, 0],
   ['config', 'VirtualMachineConfigSummary', undef, 1],
   ['quickStats', 'VirtualMachineQuickStats', undef, 1],
   ['overallStatus', 'ManagedEntityStatus', undef, 1],
   ['customValue', 'CustomFieldValue', 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineSummary', 'vm', 'runtime', 'guest', 'config', 'quickStats', 'overallStatus', 'customValue');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualMachineSummary;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualMachineSummary', 'VirtualMachineSummary', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualMachineSummary', 'VirtualMachineSummary');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineTargetInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['configurationTag', undef, 1, 0],
);


VIMRuntime::make_get_set('VirtualMachineTargetInfo', 'name', 'configurationTag');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ToolsConfigInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['toolsVersion', undef, undef, 0],
   ['afterPowerOn', 'boolean', undef, 0],
   ['afterResume', 'boolean', undef, 0],
   ['beforeGuestStandby', 'boolean', undef, 0],
   ['beforeGuestShutdown', 'boolean', undef, 0],
   ['beforeGuestReboot', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('ToolsConfigInfo', 'toolsVersion', 'afterPowerOn', 'afterResume', 'beforeGuestStandby', 'beforeGuestShutdown', 'beforeGuestReboot');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualHardware;
our @ISA = qw(DynamicData);

our @property_list = (
   ['numCPU', undef, undef, 1],
   ['memoryMB', undef, undef, 1],
   ['device', 'VirtualDevice', 1, 0],
);


VIMRuntime::make_get_set('VirtualHardware', 'numCPU', 'memoryMB', 'device');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualHardwareOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['hwVersion', undef, undef, 1],
   ['virtualDeviceOption', 'VirtualDeviceOption', 1, 1],
   ['deviceListReadonly', 'boolean', undef, 1],
   ['numCPU', undef, 1, 1],
   ['numCpuReadonly', 'boolean', undef, 1],
   ['memoryMB', 'LongOption', undef, 1],
   ['numPCIControllers', 'IntOption', undef, 1],
   ['numIDEControllers', 'IntOption', undef, 1],
   ['numUSBControllers', 'IntOption', undef, 1],
   ['numSIOControllers', 'IntOption', undef, 1],
   ['numPS2Controllers', 'IntOption', undef, 1],
   ['licensingLimit', undef, 1, 0],
);


VIMRuntime::make_get_set('VirtualHardwareOption', 'hwVersion', 'virtualDeviceOption', 'deviceListReadonly', 'numCPU', 'numCpuReadonly', 'memoryMB', 'numPCIControllers', 'numIDEControllers', 'numUSBControllers', 'numSIOControllers', 'numPS2Controllers', 'licensingLimit');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['options', 'CustomizationOptions', undef, 0],
   ['identity', 'CustomizationIdentitySettings', undef, 1],
   ['globalIPSettings', 'CustomizationGlobalIPSettings', undef, 1],
   ['nicSettingMap', 'CustomizationAdapterMapping', 1, 0],
   ['encryptionKey', undef, 1, 0],
);


VIMRuntime::make_get_set('CustomizationSpec', 'options', 'identity', 'globalIPSettings', 'nicSettingMap', 'encryptionKey');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationName;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationFixedName;
our @ISA = qw(CustomizationName);

our @property_list = (
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationFixedName', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationPrefixName;
our @ISA = qw(CustomizationName);

our @property_list = (
   ['base', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationPrefixName', 'base');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationVirtualMachineName;
our @ISA = qw(CustomizationName);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationVirtualMachineName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationUnknownName;
our @ISA = qw(CustomizationName);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationUnknownName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationCustomName;
our @ISA = qw(CustomizationName);

our @property_list = (
   ['argument', undef, undef, 0],
);


VIMRuntime::make_get_set('CustomizationCustomName', 'argument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationPassword;
our @ISA = qw(DynamicData);

our @property_list = (
   ['value', undef, undef, 1],
   ['plainText', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('CustomizationPassword', 'value', 'plainText');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationOptions;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationOptions');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationWinOptions;
our @ISA = qw(CustomizationOptions);

our @property_list = (
   ['changeSID', 'boolean', undef, 1],
   ['deleteAccounts', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('CustomizationWinOptions', 'changeSID', 'deleteAccounts');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationLinuxOptions;
our @ISA = qw(CustomizationOptions);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationLinuxOptions');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationGuiUnattended;
our @ISA = qw(DynamicData);

our @property_list = (
   ['password', 'CustomizationPassword', undef, 0],
   ['timeZone', undef, undef, 1],
   ['autoLogon', 'boolean', undef, 1],
   ['autoLogonCount', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationGuiUnattended', 'password', 'timeZone', 'autoLogon', 'autoLogonCount');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationUserData;
our @ISA = qw(DynamicData);

our @property_list = (
   ['fullName', undef, undef, 1],
   ['orgName', undef, undef, 1],
   ['computerName', 'CustomizationName', undef, 1],
   ['productId', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationUserData', 'fullName', 'orgName', 'computerName', 'productId');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationGuiRunOnce;
our @ISA = qw(DynamicData);

our @property_list = (
   ['commandList', undef, 1, 1],
);


VIMRuntime::make_get_set('CustomizationGuiRunOnce', 'commandList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationIdentification;
our @ISA = qw(DynamicData);

our @property_list = (
   ['joinWorkgroup', undef, undef, 0],
   ['joinDomain', undef, undef, 0],
   ['domainAdmin', undef, undef, 0],
   ['domainAdminPassword', 'CustomizationPassword', undef, 0],
);


VIMRuntime::make_get_set('CustomizationIdentification', 'joinWorkgroup', 'joinDomain', 'domainAdmin', 'domainAdminPassword');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationLicenseFilePrintData;
our @ISA = qw(DynamicData);

our @property_list = (
   ['autoMode', 'CustomizationLicenseDataMode', undef, 1],
   ['autoUsers', undef, undef, 0],
);


VIMRuntime::make_get_set('CustomizationLicenseFilePrintData', 'autoMode', 'autoUsers');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationIdentitySettings;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationIdentitySettings');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationSysprepText;
our @ISA = qw(CustomizationIdentitySettings);

our @property_list = (
   ['value', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationSysprepText', 'value');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationSysprep;
our @ISA = qw(CustomizationIdentitySettings);

our @property_list = (
   ['guiUnattended', 'CustomizationGuiUnattended', undef, 1],
   ['userData', 'CustomizationUserData', undef, 1],
   ['guiRunOnce', 'CustomizationGuiRunOnce', undef, 0],
   ['identification', 'CustomizationIdentification', undef, 1],
   ['licenseFilePrintData', 'CustomizationLicenseFilePrintData', undef, 0],
);


VIMRuntime::make_get_set('CustomizationSysprep', 'guiUnattended', 'userData', 'guiRunOnce', 'identification', 'licenseFilePrintData');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationLinuxPrep;
our @ISA = qw(CustomizationIdentitySettings);

our @property_list = (
   ['hostName', 'CustomizationName', undef, 1],
   ['domain', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationLinuxPrep', 'hostName', 'domain');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationGlobalIPSettings;
our @ISA = qw(DynamicData);

our @property_list = (
   ['dnsSuffixList', undef, 1, 0],
   ['dnsServerList', undef, 1, 0],
);


VIMRuntime::make_get_set('CustomizationGlobalIPSettings', 'dnsSuffixList', 'dnsServerList');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationIPSettings;
our @ISA = qw(DynamicData);

our @property_list = (
   ['ip', 'CustomizationIpGenerator', undef, 1],
   ['subnetMask', undef, undef, 0],
   ['gateway', undef, 1, 0],
   ['dnsServerList', undef, 1, 0],
   ['dnsDomain', undef, undef, 0],
   ['primaryWINS', undef, undef, 0],
   ['secondaryWINS', undef, undef, 0],
   ['netBIOS', 'CustomizationNetBIOSMode', undef, 0],
);


VIMRuntime::make_get_set('CustomizationIPSettings', 'ip', 'subnetMask', 'gateway', 'dnsServerList', 'dnsDomain', 'primaryWINS', 'secondaryWINS', 'netBIOS');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationIpGenerator;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationIpGenerator');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationDhcpIpGenerator;
our @ISA = qw(CustomizationIpGenerator);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationDhcpIpGenerator');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationFixedIp;
our @ISA = qw(CustomizationIpGenerator);

our @property_list = (
   ['ipAddress', undef, undef, 1],
);


VIMRuntime::make_get_set('CustomizationFixedIp', 'ipAddress');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationUnknownIpGenerator;
our @ISA = qw(CustomizationIpGenerator);

our @property_list = (
);


VIMRuntime::make_get_set('CustomizationUnknownIpGenerator');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationCustomIpGenerator;
our @ISA = qw(CustomizationIpGenerator);

our @property_list = (
   ['argument', undef, undef, 0],
);


VIMRuntime::make_get_set('CustomizationCustomIpGenerator', 'argument');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package CustomizationAdapterMapping;
our @ISA = qw(DynamicData);

our @property_list = (
   ['macAddress', undef, undef, 0],
   ['adapter', 'CustomizationIPSettings', undef, 1],
);


VIMRuntime::make_get_set('CustomizationAdapterMapping', 'macAddress', 'adapter');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfCustomizationAdapterMapping;
our @ISA = qw(ComplexType);

our @property_list = (
   ['CustomizationAdapterMapping', 'CustomizationAdapterMapping', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfCustomizationAdapterMapping', 'CustomizationAdapterMapping');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskMappingPartitionInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['fileSystem', undef, undef, 1],
   ['capacityInKb', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskMappingPartitionInfo', 'name', 'fileSystem', 'capacityInKb');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskMappingInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['physicalPartition', 'HostDiskMappingPartitionInfo', undef, 0],
   ['name', undef, undef, 1],
   ['exclusive', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('HostDiskMappingInfo', 'physicalPartition', 'name', 'exclusive');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskMappingPartitionOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['name', undef, undef, 1],
   ['fileSystem', undef, undef, 1],
   ['capacityInKb', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskMappingPartitionOption', 'name', 'fileSystem', 'capacityInKb');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfHostDiskMappingPartitionOption;
our @ISA = qw(ComplexType);

our @property_list = (
   ['HostDiskMappingPartitionOption', 'HostDiskMappingPartitionOption', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfHostDiskMappingPartitionOption', 'HostDiskMappingPartitionOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package HostDiskMappingOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['physicalPartition', 'HostDiskMappingPartitionOption', 1, 0],
   ['name', undef, undef, 1],
);


VIMRuntime::make_get_set('HostDiskMappingOption', 'physicalPartition', 'name');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualBusLogicController;
our @ISA = qw(VirtualSCSIController);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualBusLogicController');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualBusLogicControllerOption;
our @ISA = qw(VirtualSCSIControllerOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualBusLogicControllerOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromIsoBackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromIsoBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromPassthroughBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
   ['exclusive', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualCdromPassthroughBackingInfo', 'exclusive');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromRemotePassthroughBackingInfo;
our @ISA = qw(VirtualDeviceRemoteDeviceBackingInfo);

our @property_list = (
   ['exclusive', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualCdromRemotePassthroughBackingInfo', 'exclusive');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromAtapiBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromAtapiBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromRemoteAtapiBackingInfo;
our @ISA = qw(VirtualDeviceRemoteDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromRemoteAtapiBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdrom;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdrom');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromIsoBackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromIsoBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromPassthroughBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
   ['exclusive', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualCdromPassthroughBackingOption', 'exclusive');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromRemotePassthroughBackingOption;
our @ISA = qw(VirtualDeviceRemoteDeviceBackingOption);

our @property_list = (
   ['exclusive', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualCdromRemotePassthroughBackingOption', 'exclusive');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromAtapiBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromAtapiBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromRemoteAtapiBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromRemoteAtapiBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualCdromOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualCdromOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualController;
our @ISA = qw(VirtualDevice);

our @property_list = (
   ['busNumber', undef, undef, 1],
   ['device', undef, 1, 0],
);


VIMRuntime::make_get_set('VirtualController', 'busNumber', 'device');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualControllerOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
   ['devices', 'IntOption', undef, 1],
   ['supportedDevice', undef, 1, 0],
);


VIMRuntime::make_get_set('VirtualControllerOption', 'devices', 'supportedDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceBackingInfo;
our @ISA = qw(DynamicData);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceFileBackingInfo;
our @ISA = qw(VirtualDeviceBackingInfo);

our @property_list = (
   ['fileName', undef, undef, 1],
   ['datastore', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('VirtualDeviceFileBackingInfo', 'fileName', 'datastore');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceDeviceBackingInfo;
our @ISA = qw(VirtualDeviceBackingInfo);

our @property_list = (
   ['deviceName', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceDeviceBackingInfo', 'deviceName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceRemoteDeviceBackingInfo;
our @ISA = qw(VirtualDeviceBackingInfo);

our @property_list = (
   ['deviceName', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceRemoteDeviceBackingInfo', 'deviceName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDevicePipeBackingInfo;
our @ISA = qw(VirtualDeviceBackingInfo);

our @property_list = (
   ['pipeName', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualDevicePipeBackingInfo', 'pipeName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceConnectInfo;
our @ISA = qw(DynamicData);

our @property_list = (
   ['startConnected', 'boolean', undef, 1],
   ['allowGuestControl', 'boolean', undef, 1],
   ['connected', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceConnectInfo', 'startConnected', 'allowGuestControl', 'connected');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDevice;
our @ISA = qw(DynamicData);

our @property_list = (
   ['key', undef, undef, 1],
   ['deviceInfo', 'Description', undef, 0],
   ['backing', 'VirtualDeviceBackingInfo', undef, 0],
   ['connectable', 'VirtualDeviceConnectInfo', undef, 0],
   ['controllerKey', undef, undef, 0],
   ['unitNumber', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualDevice', 'key', 'deviceInfo', 'backing', 'connectable', 'controllerKey', 'unitNumber');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualDevice;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualDevice', 'VirtualDevice', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualDevice', 'VirtualDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceBackingOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['type', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceBackingOption', 'type');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualDeviceBackingOption;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualDeviceBackingOption', 'VirtualDeviceBackingOption', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualDeviceBackingOption', 'VirtualDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceFileBackingOption;
our @ISA = qw(VirtualDeviceBackingOption);

our @property_list = (
   ['fileNameExtensions', 'ChoiceOption', undef, 0],
);


VIMRuntime::make_get_set('VirtualDeviceFileBackingOption', 'fileNameExtensions');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceDeviceBackingOption;
our @ISA = qw(VirtualDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualDeviceDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceRemoteDeviceBackingOption;
our @ISA = qw(VirtualDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualDeviceRemoteDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDevicePipeBackingOption;
our @ISA = qw(VirtualDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualDevicePipeBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceConnectOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['startConnected', 'BoolOption', undef, 1],
   ['allowGuestControl', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceConnectOption', 'startConnected', 'allowGuestControl');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceOption;
our @ISA = qw(DynamicData);

our @property_list = (
   ['type', undef, undef, 1],
   ['connectOption', 'VirtualDeviceConnectOption', undef, 0],
   ['controllerType', undef, undef, 0],
   ['autoAssignController', 'BoolOption', undef, 0],
   ['backingOption', 'VirtualDeviceBackingOption', 1, 0],
   ['defaultBackingOptionIndex', undef, undef, 0],
   ['licensingLimit', undef, 1, 0],
   ['deprecated', 'boolean', undef, 1],
   ['plugAndPlay', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceOption', 'type', 'connectOption', 'controllerType', 'autoAssignController', 'backingOption', 'defaultBackingOptionIndex', 'licensingLimit', 'deprecated', 'plugAndPlay');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualDeviceOption;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualDeviceOption', 'VirtualDeviceOption', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualDeviceOption', 'VirtualDeviceOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDeviceConfigSpec;
our @ISA = qw(DynamicData);

our @property_list = (
   ['operation', 'VirtualDeviceConfigSpecOperation', undef, 0],
   ['fileOperation', 'VirtualDeviceConfigSpecFileOperation', undef, 0],
   ['device', 'VirtualDevice', undef, 1],
);


VIMRuntime::make_get_set('VirtualDeviceConfigSpec', 'operation', 'fileOperation', 'device');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualDeviceConfigSpec;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualDeviceConfigSpec', 'VirtualDeviceConfigSpec', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualDeviceConfigSpec', 'VirtualDeviceConfigSpec');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskSparseVer1BackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
   ['diskMode', undef, undef, 1],
   ['split', 'boolean', undef, 0],
   ['writeThrough', 'boolean', undef, 0],
   ['spaceUsedInKB', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualDiskSparseVer1BackingInfo', 'diskMode', 'split', 'writeThrough', 'spaceUsedInKB');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskSparseVer2BackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
   ['diskMode', undef, undef, 1],
   ['split', 'boolean', undef, 0],
   ['writeThrough', 'boolean', undef, 0],
   ['spaceUsedInKB', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualDiskSparseVer2BackingInfo', 'diskMode', 'split', 'writeThrough', 'spaceUsedInKB');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskFlatVer1BackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
   ['diskMode', undef, undef, 1],
   ['split', 'boolean', undef, 0],
   ['writeThrough', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('VirtualDiskFlatVer1BackingInfo', 'diskMode', 'split', 'writeThrough');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskFlatVer2BackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
   ['diskMode', undef, undef, 1],
   ['split', 'boolean', undef, 0],
   ['writeThrough', 'boolean', undef, 0],
   ['thinProvisioned', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('VirtualDiskFlatVer2BackingInfo', 'diskMode', 'split', 'writeThrough', 'thinProvisioned');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskRawDiskVer2BackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
   ['descriptorFileName', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskRawDiskVer2BackingInfo', 'descriptorFileName');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskPartitionedRawDiskVer2BackingInfo;
our @ISA = qw(VirtualDiskRawDiskVer2BackingInfo);

our @property_list = (
   ['partition', undef, 1, 1],
);


VIMRuntime::make_get_set('VirtualDiskPartitionedRawDiskVer2BackingInfo', 'partition');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskRawDiskMappingVer1BackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
   ['lunUuid', undef, undef, 0],
   ['deviceName', undef, undef, 0],
   ['compatibilityMode', undef, undef, 0],
   ['diskMode', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualDiskRawDiskMappingVer1BackingInfo', 'lunUuid', 'deviceName', 'compatibilityMode', 'diskMode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDisk;
our @ISA = qw(VirtualDevice);

our @property_list = (
   ['capacityInKB', undef, undef, 1],
   ['shares', 'SharesInfo', undef, 0],
);


VIMRuntime::make_get_set('VirtualDisk', 'capacityInKB', 'shares');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskSparseVer1BackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
   ['diskModes', 'ChoiceOption', undef, 1],
   ['split', 'BoolOption', undef, 1],
   ['writeThrough', 'BoolOption', undef, 1],
   ['growable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskSparseVer1BackingOption', 'diskModes', 'split', 'writeThrough', 'growable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskSparseVer2BackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
   ['diskMode', 'ChoiceOption', undef, 1],
   ['split', 'BoolOption', undef, 1],
   ['writeThrough', 'BoolOption', undef, 1],
   ['growable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskSparseVer2BackingOption', 'diskMode', 'split', 'writeThrough', 'growable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskFlatVer1BackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
   ['diskMode', 'ChoiceOption', undef, 1],
   ['split', 'BoolOption', undef, 1],
   ['writeThrough', 'BoolOption', undef, 1],
   ['growable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskFlatVer1BackingOption', 'diskMode', 'split', 'writeThrough', 'growable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskFlatVer2BackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
   ['diskMode', 'ChoiceOption', undef, 1],
   ['split', 'BoolOption', undef, 1],
   ['writeThrough', 'BoolOption', undef, 1],
   ['growable', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskFlatVer2BackingOption', 'diskMode', 'split', 'writeThrough', 'growable');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskRawDiskVer2BackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
   ['descriptorFileNameExtensions', 'ChoiceOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskRawDiskVer2BackingOption', 'descriptorFileNameExtensions');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskPartitionedRawDiskVer2BackingOption;
our @ISA = qw(VirtualDiskRawDiskVer2BackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualDiskPartitionedRawDiskVer2BackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskRawDiskMappingVer1BackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
   ['descriptorFileNameExtensions', 'ChoiceOption', undef, 0],
   ['compatibilityMode', 'ChoiceOption', undef, 1],
   ['diskMode', 'ChoiceOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskRawDiskMappingVer1BackingOption', 'descriptorFileNameExtensions', 'compatibilityMode', 'diskMode');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualDiskOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
   ['capacityInKB', 'LongOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualDiskOption', 'capacityInKB');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualE1000;
our @ISA = qw(VirtualEthernetCard);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualE1000');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualE1000Option;
our @ISA = qw(VirtualEthernetCardOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualE1000Option');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEnsoniq1371;
our @ISA = qw(VirtualSoundCard);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualEnsoniq1371');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEnsoniq1371Option;
our @ISA = qw(VirtualSoundCardOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualEnsoniq1371Option');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEthernetCardNetworkBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
   ['network', 'ManagedObjectReference', undef, 0],
);


VIMRuntime::make_get_set('VirtualEthernetCardNetworkBackingInfo', 'network');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEthernetCardLegacyNetworkBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualEthernetCardLegacyNetworkBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEthernetCard;
our @ISA = qw(VirtualDevice);

our @property_list = (
   ['addressType', undef, undef, 0],
   ['macAddress', undef, undef, 0],
   ['wakeOnLanEnabled', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('VirtualEthernetCard', 'addressType', 'macAddress', 'wakeOnLanEnabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEthernetCardNetworkBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualEthernetCardNetworkBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEthernetCardLegacyNetworkBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualEthernetCardLegacyNetworkBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualEthernetCardOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
   ['supportedOUI', 'ChoiceOption', undef, 1],
   ['macType', 'ChoiceOption', undef, 1],
   ['wakeOnLanEnabled', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualEthernetCardOption', 'supportedOUI', 'macType', 'wakeOnLanEnabled');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyImageBackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyImageBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyDeviceBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyRemoteDeviceBackingInfo;
our @ISA = qw(VirtualDeviceRemoteDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyRemoteDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppy;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppy');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyImageBackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyImageBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyDeviceBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyRemoteDeviceBackingOption;
our @ISA = qw(VirtualDeviceRemoteDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyRemoteDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualFloppyOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualFloppyOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualIDEController;
our @ISA = qw(VirtualController);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualIDEController');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualIDEControllerOption;
our @ISA = qw(VirtualControllerOption);

our @property_list = (
   ['numIDEDisks', 'IntOption', undef, 1],
   ['numIDECdroms', 'IntOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualIDEControllerOption', 'numIDEDisks', 'numIDECdroms');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualKeyboard;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualKeyboard');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualKeyboardOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualKeyboardOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualLsiLogicController;
our @ISA = qw(VirtualSCSIController);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualLsiLogicController');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualLsiLogicControllerOption;
our @ISA = qw(VirtualSCSIControllerOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualLsiLogicControllerOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPCIController;
our @ISA = qw(VirtualController);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualPCIController');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPCIControllerOption;
our @ISA = qw(VirtualControllerOption);

our @property_list = (
   ['numSCSIControllers', 'IntOption', undef, 1],
   ['numEthernetCards', 'IntOption', undef, 1],
   ['numVideoCards', 'IntOption', undef, 1],
   ['numSoundCards', 'IntOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualPCIControllerOption', 'numSCSIControllers', 'numEthernetCards', 'numVideoCards', 'numSoundCards');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPCNet32;
our @ISA = qw(VirtualEthernetCard);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualPCNet32');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPCNet32Option;
our @ISA = qw(VirtualEthernetCardOption);

our @property_list = (
   ['supportsMorphing', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualPCNet32Option', 'supportsMorphing');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPS2Controller;
our @ISA = qw(VirtualController);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualPS2Controller');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPS2ControllerOption;
our @ISA = qw(VirtualControllerOption);

our @property_list = (
   ['numKeyboards', 'IntOption', undef, 1],
   ['numPointingDevices', 'IntOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualPS2ControllerOption', 'numKeyboards', 'numPointingDevices');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualParallelPortFileBackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualParallelPortFileBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualParallelPortDeviceBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualParallelPortDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualParallelPort;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualParallelPort');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualParallelPortFileBackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualParallelPortFileBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualParallelPortDeviceBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualParallelPortDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualParallelPortOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualParallelPortOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPointingDeviceDeviceBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
   ['hostPointingDevice', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualPointingDeviceDeviceBackingInfo', 'hostPointingDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPointingDevice;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualPointingDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPointingDeviceBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
   ['hostPointingDevice', 'ChoiceOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualPointingDeviceBackingOption', 'hostPointingDevice');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualPointingDeviceOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualPointingDeviceOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfVirtualSCSISharing;
our @ISA = qw(ComplexType);

our @property_list = (
   ['VirtualSCSISharing', 'VirtualSCSISharing', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfVirtualSCSISharing', 'VirtualSCSISharing');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSCSIController;
our @ISA = qw(VirtualController);

our @property_list = (
   ['hotAddRemove', 'boolean', undef, 0],
   ['sharedBus', 'VirtualSCSISharing', undef, 1],
   ['scsiCtlrUnitNumber', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualSCSIController', 'hotAddRemove', 'sharedBus', 'scsiCtlrUnitNumber');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSCSIControllerOption;
our @ISA = qw(VirtualControllerOption);

our @property_list = (
   ['numSCSIDisks', 'IntOption', undef, 1],
   ['numSCSICdroms', 'IntOption', undef, 1],
   ['numSCSIPassthrough', 'IntOption', undef, 1],
   ['sharing', 'VirtualSCSISharing', 1, 1],
   ['defaultSharedIndex', undef, undef, 1],
   ['hotAddRemove', 'BoolOption', undef, 1],
   ['scsiCtlrUnitNumber', undef, undef, 1],
);


VIMRuntime::make_get_set('VirtualSCSIControllerOption', 'numSCSIDisks', 'numSCSICdroms', 'numSCSIPassthrough', 'sharing', 'defaultSharedIndex', 'hotAddRemove', 'scsiCtlrUnitNumber');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSCSIPassthroughDeviceBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSCSIPassthroughDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSCSIPassthrough;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSCSIPassthrough');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSCSIPassthroughDeviceBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSCSIPassthroughDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSCSIPassthroughOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSCSIPassthroughOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSIOController;
our @ISA = qw(VirtualController);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSIOController');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSIOControllerOption;
our @ISA = qw(VirtualControllerOption);

our @property_list = (
   ['numFloppyDrives', 'IntOption', undef, 1],
   ['numSerialPorts', 'IntOption', undef, 1],
   ['numParallelPorts', 'IntOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualSIOControllerOption', 'numFloppyDrives', 'numSerialPorts', 'numParallelPorts');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortFileBackingInfo;
our @ISA = qw(VirtualDeviceFileBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSerialPortFileBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortDeviceBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSerialPortDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortPipeBackingInfo;
our @ISA = qw(VirtualDevicePipeBackingInfo);

our @property_list = (
   ['endpoint', undef, undef, 1],
   ['noRxLoss', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('VirtualSerialPortPipeBackingInfo', 'endpoint', 'noRxLoss');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPort;
our @ISA = qw(VirtualDevice);

our @property_list = (
   ['yieldOnPoll', 'boolean', undef, 1],
);


VIMRuntime::make_get_set('VirtualSerialPort', 'yieldOnPoll');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortFileBackingOption;
our @ISA = qw(VirtualDeviceFileBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSerialPortFileBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortDeviceBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSerialPortDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortPipeBackingOption;
our @ISA = qw(VirtualDevicePipeBackingOption);

our @property_list = (
   ['endpoint', 'ChoiceOption', undef, 1],
   ['noRxLoss', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualSerialPortPipeBackingOption', 'endpoint', 'noRxLoss');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSerialPortOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
   ['yieldOnPoll', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualSerialPortOption', 'yieldOnPoll');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSoundBlaster16;
our @ISA = qw(VirtualSoundCard);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSoundBlaster16');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSoundBlaster16Option;
our @ISA = qw(VirtualSoundCardOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSoundBlaster16Option');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSoundCardDeviceBackingInfo;
our @ISA = qw(VirtualDeviceDeviceBackingInfo);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSoundCardDeviceBackingInfo');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSoundCard;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSoundCard');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSoundCardDeviceBackingOption;
our @ISA = qw(VirtualDeviceDeviceBackingOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSoundCardDeviceBackingOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualSoundCardOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualSoundCardOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualUSB;
our @ISA = qw(VirtualDevice);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualUSB');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualUSBController;
our @ISA = qw(VirtualController);

our @property_list = (
   ['autoConnectDevices', 'boolean', undef, 0],
);


VIMRuntime::make_get_set('VirtualUSBController', 'autoConnectDevices');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualUSBControllerOption;
our @ISA = qw(VirtualControllerOption);

our @property_list = (
   ['autoConnectDevices', 'BoolOption', undef, 1],
);


VIMRuntime::make_get_set('VirtualUSBControllerOption', 'autoConnectDevices');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualUSBOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualUSBOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualMachineVideoCard;
our @ISA = qw(VirtualDevice);

our @property_list = (
   ['videoRamSizeInKB', undef, undef, 0],
);


VIMRuntime::make_get_set('VirtualMachineVideoCard', 'videoRamSizeInKB');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualVideoCardOption;
our @ISA = qw(VirtualDeviceOption);

our @property_list = (
   ['videoRamSizeInKB', 'LongOption', undef, 0],
);


VIMRuntime::make_get_set('VirtualVideoCardOption', 'videoRamSizeInKB');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualVmxnet;
our @ISA = qw(VirtualEthernetCard);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualVmxnet');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package VirtualVmxnetOption;
our @ISA = qw(VirtualEthernetCardOption);

our @property_list = (
);


VIMRuntime::make_get_set('VirtualVmxnetOption');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfString;
our @ISA = qw(ComplexType);

our @property_list = (
   ['string', undef, 1, 0],
);


VIMRuntime::make_get_set('ArrayOfString', 'string');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfAnyType;
our @ISA = qw(ComplexType);

our @property_list = (
   ['anyType', 'anyType', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfAnyType', 'anyType');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfManagedObjectReference;
our @ISA = qw(ComplexType);

our @property_list = (
   ['ManagedObjectReference', 'ManagedObjectReference', 1, 0],
);


VIMRuntime::make_get_set('ArrayOfManagedObjectReference', 'ManagedObjectReference');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfInt;
our @ISA = qw(ComplexType);

our @property_list = (
   ['int', undef, 1, 0],
);


VIMRuntime::make_get_set('ArrayOfInt', 'int');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfByte;
our @ISA = qw(ComplexType);

our @property_list = (
   ['byte', undef, 1, 0],
);


VIMRuntime::make_get_set('ArrayOfByte', 'byte');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfShort;
our @ISA = qw(ComplexType);

our @property_list = (
   ['short', undef, 1, 0],
);


VIMRuntime::make_get_set('ArrayOfShort', 'short');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ArrayOfLong;
our @ISA = qw(ComplexType);

our @property_list = (
   ['long', undef, 1, 0],
);


VIMRuntime::make_get_set('ArrayOfLong', 'long');


sub get_property_list {
   my $class = shift;
   my @super_list = $class->SUPER::get_property_list();
   return (@super_list, @property_list);   
}

1;
##################################################################################




##################################################################################
package ObjectUpdateKind;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package PropertyChangeOp;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DiagnosticManagerLogCreator;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DiagnosticManagerLogFormat;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostSystemConnectionState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package LicenseManagerLicenseKey;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package LicenseFeatureInfoUnit;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package LicenseFeatureInfoState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package LicenseReservationInfoState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package ManagedEntityStatus;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package PerfFormat;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package PerfSummaryType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package PerfStatsType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package PerformanceManagerUnit;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package ValidateMigrationTestType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VMotionCompatibilityType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package SharesLevel;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package TaskFilterSpecRecursionOption;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package TaskFilterSpecTimeOption;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package TaskInfoState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachinePowerState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineConnectionState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineMovePriority;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package ActionParameter;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package StateAlarmOperator;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package MetricAlarmOperator;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DrsBehavior;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DasVmPriority;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DrsRecommendationReasonCode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package EventCategory;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package EventFilterSpecRecursionOption;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package AffinityType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package AutoStartAction;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package AutoStartWaitHeartbeatSetting;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostConfigChangeMode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostConfigChangeOperation;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DiagnosticPartitionStorageType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DiagnosticPartitionType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostDiskPartitionInfoType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostCpuPackageVendor;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package FibreChannelPortType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package InternetScsiSnsDiscoveryMethod;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package SlpDiscoveryMethod;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostMountMode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package MultipathState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package PortGroupConnecteeType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostFirewallRuleDirection;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostFirewallRuleProtocol;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package ScsiLunType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package ScsiLunState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package HostServicePolicy;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package ArrayUpdateOperation;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package DayOfWeek;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package WeekOfMonth;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachinePowerOpType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineStandbyActionType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineHtSharing;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineToolsStatus;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineGuestState;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineGuestOsFamily;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineGuestOsIdentifier;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineRelocateTransformation;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineScsiPassthroughType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualMachineTargetInfoConfigurationTag;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package CustomizationLicenseDataMode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package CustomizationNetBIOSMode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualDeviceFileExtension;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualDeviceConfigSpecOperation;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualDeviceConfigSpecFileOperation;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualDiskMode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualDiskCompatibilityMode;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualEthernetCardLegacyNetworkDeviceName;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualEthernetCardMacType;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualPointingDeviceHostChoice;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualSCSISharing;
our @ISA = qw(SimpleType);

1;
##################################################################################




##################################################################################
package VirtualSerialPortEndPoint;
our @ISA = qw(SimpleType);

1;
##################################################################################



###################################################################
package VimService;

sub new {
   my ($class, $url) = @_;
   my $self = {};
   my $vim_soap = SoapClient->new($url);
   $self->{vim_soap} = $vim_soap;
   return bless $self, $class;
}

sub save_session {
   my ($self, $file) = @_;
   my $vim_soap = $self->{vim_soap};
   $vim_soap->save_session($file);
   return;
}

sub load_session {
   my ($self, $file) = @_;
   my $vim_soap = $self->{vim_soap};
   $vim_soap->load_session($file);
   return;
}

sub unload_session {
   my ($self) = @_;
   my $vim_soap = $self->{vim_soap};
   $vim_soap->unload_session();
   return;
}

sub get_session_loaded {
   my $self = shift;
   my $vim_soap = $self->{vim_soap};
   return $vim_soap->get_session_loaded();
}

sub load_session_id {
   my ($self, $id) = @_;
   my $vim_soap = $self->{vim_soap};
   $vim_soap->load_session_id($id);
}

sub get_session_id {
   my $self = shift;
   my $vim_soap = $self->{vim_soap};
   my $id = $vim_soap->get_session_id();
   return $id;
}

sub deserialize_response {
   my ($result, $fault, $class_name, $isarray) = @_;
   my $response = SoapResponse->new;
   if ($fault) {
      my $soap_faut = new SoapFault($fault);      
      $response->fault($soap_faut);      
   } elsif ($result) {
      if ($isarray) {
         my @return_array;
         foreach (@$result) {
            if ($class_name) {
               my $obj = $class_name->deserialize($_);
               push @return_array, $obj;      
            } else {
               if ($_) {
                  push @return_array, $_->textContent;
               }
            }
         }
         $response->result(\@return_array);
      } else {
         if ($class_name) {
            $response->result($class_name->deserialize(shift @$result));     
         } else {
            my $node = shift @$result;
            if ($node) {
               $response->result($node->textContent);
            }
         }
      }
   } else {
      # void return      
   }
   return $response;
}

sub get_arg_string {   
    my ($arg, $arg_name, $expected_type) = @_;
    my $arg_string = "";

    if ($expected_type) {
        # complex type                  
        my $arg_type = ref $arg;                  
        if ($arg_type &&
            $arg_type->isa("ViewBase") &&
            $expected_type eq 'ManagedObjectReference') {
            # views can be passed off as MoRef
            $arg_type = 'ManagedObjectReference';
        }
        if (! $arg_type || ! $arg_type->isa($expected_type)) {
            Carp::confess("Expected $expected_type for '$arg_name' argument.");
        }
        # bug 236635
        if (defined($arg)) {
            if ($arg_type ne $expected_type) {
                #
                # $arg must be of derived type of $expected_type, better emit type then.
                #
                $arg_string = $arg->serialize($arg_name, $arg_type);
            } else {
                $arg_string = $arg->serialize($arg_name);
            }
        }
    } else {
        # primitive
        if (defined($arg)) {
           $arg_string = "<$arg_name>" . XmlUtil::escape_xml_string($arg) . "</$arg_name>";
        }
    }

    return $arg_string;
}

sub build_arg_string {   
   my ($arg_list, $arg_hash) = @_;
   my $arg_string;
   foreach (@$arg_list) {
      my ($arg_name, $type_name) = @$_;
      if (exists($arg_hash->{$arg_name})) {
         my $arg_value = ($arg_hash->{$arg_name});
         my $refName = ref $arg_value;
         if ($refName eq 'ARRAY') {
            foreach (@$arg_value) {
               $arg_string .= get_arg_string($_, $arg_name, $type_name);
            }
         } elsif (defined($arg_value)) {
            $arg_string .= get_arg_string($arg_value, $arg_name, $type_name);
         }
         delete $arg_hash->{$arg_name};
      }
   }
   my @leftover = keys %$arg_hash;
   if (@leftover > 0) {
      Carp::confess("Unexpected arguments: @leftover");
   }
   return $arg_string;
}

sub DestroyPropertyFilter {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DestroyPropertyFilter', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CreateFilter {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'PropertyFilterSpec'],['partialUpdates', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateFilter', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RetrieveProperties {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['specSet', 'PropertyFilterSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveProperties', $arg_string);
   return deserialize_response($result, $fault, 'ObjectContent', 1);
}

sub CheckForUpdates {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['version', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CheckForUpdates', $arg_string);
   return deserialize_response($result, $fault, 'UpdateSet', 0);
}

sub WaitForUpdates {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['version', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('WaitForUpdates', $arg_string);
   return deserialize_response($result, $fault, 'UpdateSet', 0);
}

sub CancelWaitForUpdates {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CancelWaitForUpdates', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AddAuthorizationRole {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['privIds', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddAuthorizationRole', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveAuthorizationRole {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['roleId', undef],['failIfUsed', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveAuthorizationRole', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateAuthorizationRole {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['roleId', undef],['newName', undef],['privIds', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateAuthorizationRole', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub MergePermissions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['srcRoleId', undef],['dstRoleId', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MergePermissions', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RetrieveRolePermissions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['roleId', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveRolePermissions', $arg_string);
   return deserialize_response($result, $fault, 'Permission', 1);
}

sub RetrieveEntityPermissions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['inherited', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveEntityPermissions', $arg_string);
   return deserialize_response($result, $fault, 'Permission', 1);
}

sub RetrieveAllPermissions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveAllPermissions', $arg_string);
   return deserialize_response($result, $fault, 'Permission', 1);
}

sub SetEntityPermissions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['permission', 'Permission'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetEntityPermissions', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ResetEntityPermissions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['permission', 'Permission'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ResetEntityPermissions', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveEntityPermission {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['user', undef],['isGroup', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveEntityPermission', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReconfigureCluster_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'ClusterConfigSpec'],['modify', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigureCluster_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub ApplyRecommendation {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['key', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ApplyRecommendation', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RecommendHostsForVm {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vm', 'ManagedObjectReference'],['pool', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RecommendHostsForVm', $arg_string);
   return deserialize_response($result, $fault, 'ClusterHostRecommendation', 1);
}

sub AddHost_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'HostConnectSpec'],['asConnected', undef],['resourcePool', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddHost_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub MoveInto_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MoveInto_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub MoveHostInto_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['resourcePool', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MoveHostInto_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub AddCustomFieldDef {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddCustomFieldDef', $arg_string);
   return deserialize_response($result, $fault, 'CustomFieldDef', 0);
}

sub RemoveCustomFieldDef {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['key', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveCustomFieldDef', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RenameCustomFieldDef {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['key', undef],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RenameCustomFieldDef', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub SetField {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['key', undef],['value', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetField', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DoesCustomizationSpecExist {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DoesCustomizationSpecExist', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub GetCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('GetCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, 'CustomizationSpecItem', 0);
}

sub CreateCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['item', 'CustomizationSpecItem'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub OverwriteCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['item', 'CustomizationSpecItem'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('OverwriteCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DeleteCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DeleteCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DuplicateCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['newName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DuplicateCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RenameCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['newName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RenameCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CustomizationSpecItemToXml {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['item', 'CustomizationSpecItem'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CustomizationSpecItemToXml', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub XmlToCustomizationSpecItem {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['specItemXml', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('XmlToCustomizationSpecItem', $arg_string);
   return deserialize_response($result, $fault, 'CustomizationSpecItem', 0);
}

sub CheckCustomizationResources {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['guestOs', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CheckCustomizationResources', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryConnectionInfo {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['hostname', undef],['port', undef],['username', undef],['password', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryConnectionInfo', $arg_string);
   return deserialize_response($result, $fault, 'HostConnectInfo', 0);
}

sub RenameDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['newName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RenameDatastore', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RefreshDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RefreshDatastore', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DestroyDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DestroyDatastore', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryDescriptions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryDescriptions', $arg_string);
   return deserialize_response($result, $fault, 'DiagnosticManagerLogDescriptor', 1);
}

sub BrowseDiagnosticLog {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['key', undef],['start', undef],['lines', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('BrowseDiagnosticLog', $arg_string);
   return deserialize_response($result, $fault, 'DiagnosticManagerLogHeader', 0);
}

sub GenerateLogBundles_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['includeDefault', undef],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('GenerateLogBundles_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub QueryConfigOptionDescriptor {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryConfigOptionDescriptor', $arg_string);
   return deserialize_response($result, $fault, 'VirtualMachineConfigOptionDescriptor', 1);
}

sub QueryConfigOption {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['key', undef],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryConfigOption', $arg_string);
   return deserialize_response($result, $fault, 'VirtualMachineConfigOption', 0);
}

sub QueryConfigTarget {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryConfigTarget', $arg_string);
   return deserialize_response($result, $fault, 'ConfigTarget', 0);
}

sub CreateFolder {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateFolder', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub MoveIntoFolder_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['list', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MoveIntoFolder_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CreateVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['config', 'VirtualMachineConfigSpec'],['pool', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RegisterVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['path', undef],['name', undef],['asTemplate', undef],['pool', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RegisterVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CreateCluster {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['spec', 'ClusterConfigSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateCluster', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub AddStandaloneHost_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'HostConnectSpec'],['addConnected', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddStandaloneHost_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CreateDatacenter {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateDatacenter', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub UnregisterAndDestroy_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UnregisterAndDestroy_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub SetCollectorPageSize {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['maxCount', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetCollectorPageSize', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RewindCollector {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RewindCollector', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ResetCollector {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ResetCollector', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DestroyCollector {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DestroyCollector', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryHostConnectionInfo {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryHostConnectionInfo', $arg_string);
   return deserialize_response($result, $fault, 'HostConnectInfo', 0);
}

sub UpdateSystemResources {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['resourceInfo', 'HostSystemResourceInfo'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateSystemResources', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReconnectHost_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['cnxSpec', 'HostConnectSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconnectHost_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub DisconnectHost_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DisconnectHost_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub EnterMaintenanceMode_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['timeout', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('EnterMaintenanceMode_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub ExitMaintenanceMode_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['timeout', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ExitMaintenanceMode_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RebootHost_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['force', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RebootHost_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub ShutdownHost_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['force', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ShutdownHost_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub QueryMemoryOverhead {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['memorySize', undef],['videoRamSize', undef],['numVcpus', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryMemoryOverhead', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReconfigureHostForDAS_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigureHostForDAS_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub QueryLicenseSourceAvailability {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryLicenseSourceAvailability', $arg_string);
   return deserialize_response($result, $fault, 'LicenseAvailabilityInfo', 1);
}

sub QueryLicenseUsage {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryLicenseUsage', $arg_string);
   return deserialize_response($result, $fault, 'LicenseUsageInfo', 0);
}

sub SetLicenseEdition {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['featureKey', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetLicenseEdition', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CheckLicenseFeature {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['featureKey', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CheckLicenseFeature', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub EnableFeature {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['featureKey', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('EnableFeature', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DisableFeature {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['featureKey', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DisableFeature', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ConfigureLicenseSource {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['licenseSource', 'LicenseSource'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ConfigureLicenseSource', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub Reload {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('Reload', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub Rename_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['newName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('Rename_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub Destroy_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('Destroy_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub DestroyNetwork {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DestroyNetwork', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryPerfProviderSummary {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryPerfProviderSummary', $arg_string);
   return deserialize_response($result, $fault, 'PerfProviderSummary', 0);
}

sub QueryAvailablePerfMetric {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['beginTime', undef],['endTime', undef],['intervalId', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryAvailablePerfMetric', $arg_string);
   return deserialize_response($result, $fault, 'PerfMetricId', 1);
}

sub QueryPerfCounter {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['counterId', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryPerfCounter', $arg_string);
   return deserialize_response($result, $fault, 'PerfCounterInfo', 1);
}

sub QueryPerf {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['querySpec', 'PerfQuerySpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryPerf', $arg_string);
   return deserialize_response($result, $fault, 'PerfEntityMetricBase', 1);
}

sub QueryPerfComposite {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['querySpec', 'PerfQuerySpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryPerfComposite', $arg_string);
   return deserialize_response($result, $fault, 'PerfCompositeMetric', 0);
}

sub CreatePerfInterval {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['intervalId', 'PerfInterval'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreatePerfInterval', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemovePerfInterval {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['samplePeriod', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemovePerfInterval', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdatePerfInterval {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['interval', 'PerfInterval'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdatePerfInterval', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['config', 'ResourceConfigSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateConfig', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub MoveIntoResourcePool {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['list', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MoveIntoResourcePool', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateChildResourceConfiguration {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'ResourceConfigSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateChildResourceConfiguration', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CreateResourcePool {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['spec', 'ResourceConfigSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateResourcePool', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub DestroyChildren {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DestroyChildren', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub FindByUuid {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datacenter', 'ManagedObjectReference'],['uuid', undef],['vmSearch', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FindByUuid', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub FindByDatastorePath {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datacenter', 'ManagedObjectReference'],['path', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FindByDatastorePath', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub FindByDnsName {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datacenter', 'ManagedObjectReference'],['dnsName', undef],['vmSearch', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FindByDnsName', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub FindByIp {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datacenter', 'ManagedObjectReference'],['ip', undef],['vmSearch', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FindByIp', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub FindByInventoryPath {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['inventoryPath', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FindByInventoryPath', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub FindChild {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FindChild', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CurrentTime {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CurrentTime', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RetrieveServiceContent {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveServiceContent', $arg_string);
   return deserialize_response($result, $fault, 'ServiceContent', 0);
}

sub ValidateMigration {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vm', 'ManagedObjectReference'],['state', 'VirtualMachinePowerState'],['testType', undef],['pool', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ValidateMigration', $arg_string);
   return deserialize_response($result, $fault, 'Event', 1);
}

sub QueryVMotionCompatibility {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vm', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['compatibility', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryVMotionCompatibility', $arg_string);
   return deserialize_response($result, $fault, 'HostVMotionCompatibility', 1);
}

sub UpdateServiceMessage {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['message', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateServiceMessage', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub Login {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['userName', undef],['password', undef],['locale', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('Login', $arg_string);
   return deserialize_response($result, $fault, 'UserSession', 0);
}

sub Logout {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('Logout', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AcquireLocalTicket {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['userName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AcquireLocalTicket', $arg_string);
   return deserialize_response($result, $fault, 'SessionManagerLocalTicket', 0);
}

sub TerminateSession {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['sessionId', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('TerminateSession', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub SetLocale {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['locale', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetLocale', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CancelTask {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CancelTask', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReadNextTasks {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['maxCount', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReadNextTasks', $arg_string);
   return deserialize_response($result, $fault, 'TaskInfo', 1);
}

sub ReadPreviousTasks {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['maxCount', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReadPreviousTasks', $arg_string);
   return deserialize_response($result, $fault, 'TaskInfo', 1);
}

sub CreateCollectorForTasks {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['filter', 'TaskFilterSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateCollectorForTasks', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RetrieveUserGroups {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['domain', undef],['searchStr', undef],['belongsToGroup', undef],['belongsToUser', undef],['exactMatch', undef],['findUsers', undef],['findGroups', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveUserGroups', $arg_string);
   return deserialize_response($result, $fault, 'UserSearchResult', 1);
}

sub CreateSnapshot_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['description', undef],['memory', undef],['quiesce', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateSnapshot_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RevertToCurrentSnapshot_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RevertToCurrentSnapshot_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RemoveAllSnapshots_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveAllSnapshots_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub ReconfigVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'VirtualMachineConfigSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub UpgradeVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['version', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpgradeVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub PowerOnVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('PowerOnVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub PowerOffVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('PowerOffVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub SuspendVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SuspendVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub ResetVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ResetVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub ShutdownGuest {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ShutdownGuest', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RebootGuest {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RebootGuest', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub StandbyGuest {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('StandbyGuest', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AnswerVM {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['questionId', undef],['answerChoice', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AnswerVM', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CustomizeVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'CustomizationSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CustomizeVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CheckCustomizationSpec {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'CustomizationSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CheckCustomizationSpec', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub MigrateVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['pool', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],['priority', 'VirtualMachineMovePriority'],['state', 'VirtualMachinePowerState'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MigrateVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RelocateVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'VirtualMachineRelocateSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RelocateVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CloneVM_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['folder', 'ManagedObjectReference'],['name', undef],['spec', 'VirtualMachineCloneSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CloneVM_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub MarkAsTemplate {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MarkAsTemplate', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub MarkAsVirtualMachine {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['pool', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MarkAsVirtualMachine', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UnregisterVM {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UnregisterVM', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ResetGuestInformation {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ResetGuestInformation', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub MountToolsInstaller {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('MountToolsInstaller', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UnmountToolsInstaller {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UnmountToolsInstaller', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpgradeTools_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['installerOptions', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpgradeTools_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub AcquireMksTicket {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AcquireMksTicket', $arg_string);
   return deserialize_response($result, $fault, 'VirtualMachineMksTicket', 0);
}

sub SetScreenResolution {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['width', undef],['height', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetScreenResolution', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveAlarm {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveAlarm', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReconfigureAlarm {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'AlarmSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigureAlarm', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CreateAlarm {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['spec', 'AlarmSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateAlarm', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub GetAlarm {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('GetAlarm', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 1);
}

sub GetAlarmState {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('GetAlarmState', $arg_string);
   return deserialize_response($result, $fault, 'AlarmState', 1);
}

sub ReadNextEvents {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['maxCount', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReadNextEvents', $arg_string);
   return deserialize_response($result, $fault, 'Event', 1);
}

sub ReadPreviousEvents {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['maxCount', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReadPreviousEvents', $arg_string);
   return deserialize_response($result, $fault, 'Event', 1);
}

sub CreateCollectorForEvents {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['filter', 'EventFilterSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateCollectorForEvents', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub LogUserEvent {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['msg', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('LogUserEvent', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryEvents {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['filter', 'EventFilterSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryEvents', $arg_string);
   return deserialize_response($result, $fault, 'Event', 1);
}

sub ReconfigureAutostart {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'HostAutoStartManagerConfig'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigureAutostart', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AutoStartPowerOn {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AutoStartPowerOn', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AutoStartPowerOff {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AutoStartPowerOff', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub EnableHyperThreading {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('EnableHyperThreading', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DisableHyperThreading {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DisableHyperThreading', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub SearchDatastore_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastorePath', undef],['searchSpec', 'HostDatastoreBrowserSearchSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SearchDatastore_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub SearchDatastoreSubFolders_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastorePath', undef],['searchSpec', 'HostDatastoreBrowserSearchSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SearchDatastoreSubFolders_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub DeleteFile {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastorePath', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DeleteFile', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryAvailableDisksForVmfs {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastore', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryAvailableDisksForVmfs', $arg_string);
   return deserialize_response($result, $fault, 'HostScsiDisk', 1);
}

sub QueryVmfsDatastoreCreateOptions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['devicePath', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryVmfsDatastoreCreateOptions', $arg_string);
   return deserialize_response($result, $fault, 'VmfsDatastoreOption', 1);
}

sub CreateVmfsDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'VmfsDatastoreCreateSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateVmfsDatastore', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub QueryVmfsDatastoreExtendOptions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastore', 'ManagedObjectReference'],['devicePath', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryVmfsDatastoreExtendOptions', $arg_string);
   return deserialize_response($result, $fault, 'VmfsDatastoreOption', 1);
}

sub ExtendVmfsDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastore', 'ManagedObjectReference'],['spec', 'VmfsDatastoreExtendSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ExtendVmfsDatastore', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CreateNasDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'HostNasVolumeSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateNasDatastore', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub CreateLocalDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['path', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateLocalDatastore', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RemoveDatastore {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['datastore', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveDatastore', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ConfigureDatastorePrincipal {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['userName', undef],['password', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ConfigureDatastorePrincipal', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryAvailablePartition {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryAvailablePartition', $arg_string);
   return deserialize_response($result, $fault, 'HostDiagnosticPartition', 1);
}

sub SelectActivePartition {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['partition', 'HostScsiDiskPartition'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SelectActivePartition', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryPartitionCreateOptions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['storageType', undef],['diagnosticType', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryPartitionCreateOptions', $arg_string);
   return deserialize_response($result, $fault, 'HostDiagnosticPartitionCreateOption', 1);
}

sub QueryPartitionCreateDesc {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['diskUuid', undef],['diagnosticType', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryPartitionCreateDesc', $arg_string);
   return deserialize_response($result, $fault, 'HostDiagnosticPartitionCreateDescription', 0);
}

sub CreateDiagnosticPartition {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'HostDiagnosticPartitionCreateSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateDiagnosticPartition', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RenewLease {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RenewLease', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReleaseLease {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReleaseLease', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateDefaultPolicy {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['defaultPolicy', 'HostFirewallDefaultPolicy'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateDefaultPolicy', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub EnableRuleset {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('EnableRuleset', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DisableRuleset {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DisableRuleset', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RefreshFirewall {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RefreshFirewall', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CreateUser {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['user', 'HostAccountSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateUser', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateUser {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['user', 'HostAccountSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateUser', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CreateGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['group', 'HostAccountSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveUser {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['userName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveUser', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['groupName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AssignUserToGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['user', undef],['group', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AssignUserToGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UnassignUserFromGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['user', undef],['group', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UnassignUserFromGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReconfigureServiceConsoleReservation {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['cfgBytes', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigureServiceConsoleReservation', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateNetworkConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['config', 'HostNetworkConfig'],['changeMode', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateNetworkConfig', $arg_string);
   return deserialize_response($result, $fault, 'HostNetworkConfigResult', 0);
}

sub UpdateDnsConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['config', 'HostDnsConfig'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateDnsConfig', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateIpRouteConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['config', 'HostIpRouteConfig'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateIpRouteConfig', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateConsoleIpRouteConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['config', 'HostIpRouteConfig'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateConsoleIpRouteConfig', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AddVirtualSwitch {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vswitchName', undef],['spec', 'HostVirtualSwitchSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddVirtualSwitch', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveVirtualSwitch {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vswitchName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveVirtualSwitch', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateVirtualSwitch {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vswitchName', undef],['spec', 'HostVirtualSwitchSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateVirtualSwitch', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AddPortGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['portgrp', 'HostPortGroupSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddPortGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemovePortGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['pgName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemovePortGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdatePortGroup {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['pgName', undef],['portgrp', 'HostPortGroupSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdatePortGroup', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdatePhysicalNicLinkSpeed {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],['linkSpeed', 'PhysicalNicLinkInfo'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdatePhysicalNicLinkSpeed', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryNetworkHint {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryNetworkHint', $arg_string);
   return deserialize_response($result, $fault, 'PhysicalNicHintInfo', 1);
}

sub AddVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['portgroup', undef],['nic', 'HostVirtualNicSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],['nic', 'HostVirtualNicSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AddServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['portgroup', undef],['nic', 'HostVirtualNicSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddServiceConsoleVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveServiceConsoleVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],['nic', 'HostVirtualNicSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateServiceConsoleVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RestartServiceConsoleVirtualNic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RestartServiceConsoleVirtualNic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RefreshNetworkSystem {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RefreshNetworkSystem', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateServicePolicy {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],['policy', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateServicePolicy', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub StartService {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('StartService', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub StopService {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('StopService', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RestartService {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RestartService', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UninstallService {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['id', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UninstallService', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RefreshServices {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RefreshServices', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CheckIfMasterSnmpAgentRunning {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CheckIfMasterSnmpAgentRunning', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateSnmpConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['config', 'HostSnmpConfig'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateSnmpConfig', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RestartMasterSnmpAgent {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RestartMasterSnmpAgent', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub StopMasterSnmpAgent {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('StopMasterSnmpAgent', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RetrieveDiskPartitionInfo {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['devicePath', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveDiskPartitionInfo', $arg_string);
   return deserialize_response($result, $fault, 'HostDiskPartitionInfo', 1);
}

sub ComputeDiskPartitionInfo {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['devicePath', undef],['layout', 'HostDiskPartitionLayout'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ComputeDiskPartitionInfo', $arg_string);
   return deserialize_response($result, $fault, 'HostDiskPartitionInfo', 0);
}

sub UpdateDiskPartitions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['devicePath', undef],['spec', 'HostDiskPartitionSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateDiskPartitions', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub FormatVmfs {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['createSpec', 'HostVmfsSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('FormatVmfs', $arg_string);
   return deserialize_response($result, $fault, 'HostVmfsVolume', 0);
}

sub RescanVmfs {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RescanVmfs', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AttachVmfsExtent {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vmfsPath', undef],['extent', 'HostScsiDiskPartition'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AttachVmfsExtent', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpgradeVmfs {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['vmfsPath', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpgradeVmfs', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpgradeVmLayout {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpgradeVmLayout', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RescanHba {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['hbaDevice', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RescanHba', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RescanAllHba {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RescanAllHba', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateSoftwareInternetScsiEnabled {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['enabled', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateSoftwareInternetScsiEnabled', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateInternetScsiDiscoveryProperties {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['discoveryProperties', 'HostInternetScsiHbaDiscoveryProperties'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateInternetScsiDiscoveryProperties', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateInternetScsiAuthenticationProperties {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['authenticationProperties', 'HostInternetScsiHbaAuthenticationProperties'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateInternetScsiAuthenticationProperties', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateInternetScsiIPProperties {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['ipProperties', 'HostInternetScsiHbaIPProperties'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateInternetScsiIPProperties', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateInternetScsiName {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['iScsiName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateInternetScsiName', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateInternetScsiAlias {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['iScsiAlias', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateInternetScsiAlias', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AddInternetScsiSendTargets {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['targets', 'HostInternetScsiHbaSendTarget'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddInternetScsiSendTargets', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveInternetScsiSendTargets {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['targets', 'HostInternetScsiHbaSendTarget'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveInternetScsiSendTargets', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub AddInternetScsiStaticTargets {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['targets', 'HostInternetScsiHbaStaticTarget'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('AddInternetScsiStaticTargets', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveInternetScsiStaticTargets {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['iScsiHbaDevice', undef],['targets', 'HostInternetScsiHbaStaticTarget'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveInternetScsiStaticTargets', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub EnableMultipathPath {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['pathName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('EnableMultipathPath', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DisableMultipathPath {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['pathName', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DisableMultipathPath', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub SetMultipathLunPolicy {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['lunId', undef],['policy', 'HostMultipathInfoLogicalUnitPolicy'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SetMultipathLunPolicy', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RefreshStorageSystem {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RefreshStorageSystem', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub UpdateIpConfig {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['ipConfig', 'HostIpConfig'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateIpConfig', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub SelectVnic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['device', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('SelectVnic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub DeselectVnic {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('DeselectVnic', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub QueryOptions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('QueryOptions', $arg_string);
   return deserialize_response($result, $fault, 'OptionValue', 1);
}

sub UpdateOptions {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['changedValue', 'OptionValue'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('UpdateOptions', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RemoveScheduledTask {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveScheduledTask', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub ReconfigureScheduledTask {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['spec', 'ScheduledTaskSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('ReconfigureScheduledTask', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub RunScheduledTask {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RunScheduledTask', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}

sub CreateScheduledTask {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],['spec', 'ScheduledTaskSpec'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('CreateScheduledTask', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RetrieveEntityScheduledTask {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['entity', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RetrieveEntityScheduledTask', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 1);
}

sub RevertToSnapshot_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['host', 'ManagedObjectReference'],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RevertToSnapshot_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RemoveSnapshot_Task {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['removeChildren', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RemoveSnapshot_Task', $arg_string);
   return deserialize_response($result, $fault, 'ManagedObjectReference', 0);
}

sub RenameSnapshot {
   my ($self, %args) = @_;
   my $vim_soap = $self->{vim_soap};
   my @arg_list = (['_this', 'ManagedObjectReference'],['name', undef],['description', undef],);
   my $arg_string = build_arg_string(\@arg_list, \%args);
   my ($result, $fault) = $vim_soap->request('RenameSnapshot', $arg_string);
   return deserialize_response($result, $fault, undef, 0);
}



1;
###################################################################


__END__
=head1 NAME

VMware::VIStub - Perl binding for VMware Infrastructure API

=head1 SYNOPSIS

  use VMware::VIStub;

  # service object
  my $vim_service = VimService->new('https://<host>/sdk');

  # get service content
  my $mo = ManagedObjectReference->new(type => 'ServiceInstance', value => 'ServiceInstance');
  my $service_content = $vim_service->RetrieveServiceContent(_this => $mo)->result;
  

=head1 DESCRIPTION

This module provides Perl binding for VMware Infrastructure API.  It provides type
and operation definitions as specified by the VMware Infrastructure API.
For detailed documentation, refer to reference guide in VI SDK distribution
downloadable at <http://www.vmware.com/download/sdk/>


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

