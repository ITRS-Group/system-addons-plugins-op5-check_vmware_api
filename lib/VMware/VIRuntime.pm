#
# Copyright 2006 VMware, Inc.  All rights reserved.
#

# This module is a 'link' of sort to the latest version of API / runtime toolkit supports.
# Using this module instead of referencing a specific version of runtime modules has a 
# potential of breaking existing scripts when toolkit installation is upgraded.  


use 5.006001;
use strict;
use warnings;

require VMware::VILib;
require VMware::VICommon;

package VMware::VIRuntime;

our $VERSION = '5.1.0';

1;
