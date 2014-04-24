#
# Cookbook Name:: rackspace_jboss
# Recipe:: jboss_setup
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
bin_dir  = "#{node['rackspace_jboss']['jboss_install_path']}/bin"
conf_dir = "#{node['rackspace_jboss']['jboss_install_path']}/#{node['rackspace_jboss']['jboss_type']}/configuration"

directory node['rackspace_jboss']['jboss_as_conf']['dir'] do
  owner     'root'
  mode      '0755'
  recursive true
  action    :create
end

template "#{conf_dir}/#{node['rackspace_jboss']['jboss_xml_file']}" do
  cookbook  node['rackspace_jboss']['templates']['jboss_xml_file']
  source    "#{node['rackspace_jboss']['jboss_xml_file']}.erb"
  owner     node['rackspace_jboss']['jboss_user']
  mode      '0644'
  variables(cookbook_name: cookbook_name)
  not_if   { node['rackspace_jboss']['templates']['customer_supplied']['jboss_xml_file'] }
end

template '/etc/init.d/jboss' do
  cookbook  node['rackspace_jboss']['templates']['jboss.init']
  source    'jboss.init.erb'
  owner     'root'
  group     'root'
  mode      '0755'
  variables(cookbook_name: cookbook_name)
  not_if   { node['rackspace_jboss']['templates']['customer_supplied']['jboss.init'] }
end

template node['rackspace_jboss']['config']['jboss_as_conf'] do
  cookbook  node['rackspace_jboss']['templates']['jboss_as.conf']
  source    'jboss_as.conf.erb'
  owner     'root'
  group     'root'
  mode      '0644'
  notifies  :restart, 'service[jboss]'
  variables(cookbook_name: cookbook_name)
  not_if   { node['rackspace_jboss']['templates']['customer_supplied']['jboss_as.conf'] }
end

template "#{bin_dir}/standalone.conf" do
  cookbook  node['rackspace_jboss']['templates']['standalone.conf']
  source    'standalone.conf.erb'
  owner     node['rackspace_jboss']['jboss_user']
  mode      '0644'
  notifies  :restart, 'service[jboss]'
  variables(cookbook_name: cookbook_name)
  not_if   { node['rackspace_jboss']['templates']['customer_supplied']['standalone.conf'] }
end

template "#{conf_dir}/mgmt-users.properties" do
  cookbook  node['rackspace_jboss']['templates']['mgmt-users.properties']
  source    'mgmt-users.properties.erb'
  owner     node['rackspace_jboss']['jboss_user']
  mode      '0644'
  variables(cookbook_name: cookbook_name)
  not_if   { node['rackspace_jboss']['templates']['customer_supplied']['mgmt-users.properties'] }
end

template "#{conf_dir}/application-users.properties" do
  cookbook  node['rackspace_jboss']['templates']['application-users.properties']
  source    'application-users.properties.erb'
  owner     node['rackspace_jboss']['jboss_user']
  mode      '0644'
  variables(cookbook_name: cookbook_name)
  not_if   { node['rackspace_jboss']['templates']['customer_supplied']['application-users.properties'] }
end
