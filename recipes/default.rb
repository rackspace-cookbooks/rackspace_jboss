#
# Cookbook Name:: rackspace_jboss
# Recipe:: default
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
include_recipe 'rackspace_jboss::java_install'

node['rackspace_jboss']['JAVA_OPTS']['set'].each do |_name, value|
  node.default['rackspace_jboss']['config']['JAVA_OPTS'].push(value)
end

include_recipe 'rackspace_jboss::jboss_user'
include_recipe 'rackspace_jboss::jboss_install'
include_recipe 'rackspace_jboss::jboss_setup'

if node['rackspace_jboss']['mysql_jdbc']['enabled']
  include_recipe 'rackspace_jboss::mysql_jdbc'
end

service 'jboss' do
  supports status: true, restart: true, reload: false
  action   [:enable, :start]
end
