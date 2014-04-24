#
# Cookbook Name:: rackspace_jboss
# Attributes:: default
#
# Copyright 2014, Rackspace, US Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['rackspace_jboss']['jboss_home']                                                      = '/opt/jboss'
default['rackspace_jboss']['jboss_user']                                                      = 'jboss'
default['rackspace_jboss']['jboss_uid']                                                       = nil

# Tested versions: '7.0.0.Final', '7.0.1.Final', '7.0.2.Final', '7.1.0.Final', '7.1.1.Final'
# non .Final versions should work in theory.
default['rackspace_jboss']['jboss_version']                                                   = '7.1.1.Final'

# Allows override of install path, in case jboss is installed somewhere other than
# the top level of the jboss user's home dir.  This only adapts to existing installs.
# Currently, new installs will still deploy to ['jboss_home']/jboss-as-['jboss_version'].
default['rackspace_jboss']['jboss_install_path']                                              =
  "#{node['rackspace_jboss']['jboss_home']}/jboss-as-#{node['rackspace_jboss']['jboss_version']}"

# Only 'standalone' is valid at this time.  Future iterations should expand
# upon this to include all standalone variants, and domain variants.
default['rackspace_jboss']['jboss_type']                                                      = 'standalone'
default['rackspace_jboss']['jboss_xml_file']                                                  = 'standalone.xml'

# Valid install flavors: 'oracle', 'openjdk'
# Rackspace recommends oracle due to its better instrumentation, and better
# debugging utilities.  RedHat recommends openjdk.
default['rackspace_jboss']['jdk_flavor']                                                      = 'oracle'

# Valid JDK Versions: '6', '7'
default['rackspace_jboss']['jdk_version']                                                     = '7'

default['rackspace_jboss']['jboss_as_conf']['dir']                                            = '/etc/jboss'
default['rackspace_jboss']['config']['jboss_as_conf']                                         = "#{node['rackspace_jboss']['jboss_as_conf']['dir']}/jboss-as.conf"

default['rackspace_jboss']['config']['public_listen_address']                                 = '0.0.0.0'
default['rackspace_jboss']['config']['management_listen_address']                             = '0.0.0.0'

default['rackspace_jboss']['templates']['application-users.properties']                       = 'rackspace_jboss'
default['rackspace_jboss']['templates']['jboss.init']                                         = 'rackspace_jboss'
default['rackspace_jboss']['templates']['jboss_as.conf']                                      = 'rackspace_jboss'
default['rackspace_jboss']['templates']['mgmt-users.properties']                              = 'rackspace_jboss'
default['rackspace_jboss']['templates']['mysql_jdbc_module.xml']                              = 'rackspace_jboss'
default['rackspace_jboss']['templates']['standalone.conf']                                    = 'rackspace_jboss'
default['rackspace_jboss']['templates']['jboss_xml_file']                                     = 'rackspace_jboss'

default['rackspace_jboss']['templates']['customer_supplied']['application-users.properties']  = false
default['rackspace_jboss']['templates']['customer_supplied']['jboss.init']                    = false
default['rackspace_jboss']['templates']['customer_supplied']['jboss_as.conf']                 = false
default['rackspace_jboss']['templates']['customer_supplied']['mgmt-users.properties']         = false
default['rackspace_jboss']['templates']['customer_supplied']['mysql_jdbc_module.xml']         = false
default['rackspace_jboss']['templates']['customer_supplied']['standalone.conf']               = false
default['rackspace_jboss']['templates']['customer_supplied']['jboss_xml_file']                = false
