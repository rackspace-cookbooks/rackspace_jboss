#
# Cookbook Name:: rackspace_jboss
# Recipe:: java_install
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
node.set['rackspace_java']['install_flavor'] = node['rackspace_jboss']['jdk_flavor']
node.set['rackspace_java']['jdk_version']    = node['rackspace_jboss']['jdk_version']
if node['rackspace_jboss']['jdk_flavor'] == 'oracle'
  node.set['rackspace_java']['oracle']['accept_oracle_download_terms'] = true
end
include_recipe 'rackspace_java'
