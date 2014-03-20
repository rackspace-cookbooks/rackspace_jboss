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

default['rackspace_jboss']['jboss_home']                          = '/opt/jboss'
default['rackspace_jboss']['jboss_user']                          = 'jboss'
default['rackspace_jboss']['jboss_uid']                           = nil

# Valid versions: '7.0.0', '7.0.1', '7.0.2', '7.1.0', '7.1.1'
default['rackspace_jboss']['jboss_version']                       = '7.1.1'

# Only 'standalone' is valid at this time.  Future iterations should expand
# upon this to include all standalone variants, and domain variants.
default['rackspace_jboss']['jboss_type']                          = 'standalone'
default['rackspace_jboss']['jboss_xml_file']                      = 'standalone.xml'

# Valid install flavors: 'oracle', 'openjdk'
# Rackspace recommends oracle due to its better instrumentation, and better
# debugging utilities.  RedHat recommends openjdk.
node.set['java']['install_flavor']                                = 'oracle'

# Valid JDK Versions: '6', '7'
node.set['java']['jdk_version']                                   = '7'

if node['java']['install_flavor'] == 'oracle'
  node.set['java']['oracle']['accept_oracle_download_terms']      = true
end

default['rackspace_jboss']['jboss_as_conf']['dir']                = '/etc/jboss'
default['rackspace_jboss']['config']['jboss_as_conf']             = "#{node['rackspace_jboss']['jboss_as_conf']['dir']}/jboss-as.conf"

default['rackspace_jboss']['config']['public_listen_address']     = '0.0.0.0'
default['rackspace_jboss']['config']['management_listen_address'] = '0.0.0.0'
