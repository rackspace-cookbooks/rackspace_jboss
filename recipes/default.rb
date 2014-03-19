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

include_recipe 'java'

vers     = node['rackspace_jboss']['jboss_version']
mmvers   = vers.split('.')[0] + '.' + vers.split('.')[1]
bin_dir  = "#{node['rackspace_jboss']['jboss_home']}/jboss-as-#{vers}.Final/bin"
conf_dir = "#{node['rackspace_jboss']['jboss_home']}/jboss-as-#{vers}.Final/#{node['rackspace_jboss']['jboss_type']}/configuration"

remote_file "#{Chef::Config[:file_cache_path]}/jboss-as-#{vers}.Final.tar.gz" do
  source "http://download.jboss.org/jbossas/#{mmvers}/jboss-as-#{vers}.Final/jboss-as-#{vers}.Final.tar.gz"
  action :create_if_missing
end

user node['rackspace_jboss']['jboss_user'] do
  home  node['rackspace_jboss']['jboss_home']
  shell '/sbin/nologin'
  uid   254
  system true
end

directory node['rackspace_jboss']['jboss_home'] do
  owner  node['rackspace_jboss']['jboss_user']
  mode   '0755'
  action :create
end

directory node['rackspace_jboss']['jboss_as_conf']['dir'] do
  owner     'root'
  mode      '0755'
  recursive true
  action    :create
end

bash 'deploy_jboss' do
  not_if { File.exists?("#{bin_dir}/standalone.sh") }
  user node['rackspace_jboss']['jboss_user']
  cwd  node['rackspace_jboss']['jboss_home']
  code <<-EOH
    tar zxf #{Chef::Config[:file_cache_path]}/jboss-as-#{vers}.Final.tar.gz
  EOH
end

template "#{conf_dir}/#{node['rackspace_jboss']['jboss_xml_file']}" do
  source "#{node['rackspace_jboss']['jboss_xml_file']}.erb"
  owner node['rackspace_jboss']['jboss_user']
  mode  '0644'
  variables(cookbook_name: cookbook_name)
end

template '/etc/init.d/jboss' do
  source 'jboss.init.erb'
  owner 'root'
  group 'root'
  mode  '0755'
  variables(cookbook_name: cookbook_name)
end

template node['rackspace_jboss']['config']['jboss_as_conf'] do
  source 'jboss_as.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, 'service[jboss]'
  variables(cookbook_name: cookbook_name)
end

template "#{conf_dir}/mgmt-users.properties" do
  source 'mgmt-users.properties.erb'
  owner node['rackspace_jboss']['jboss_user']
  mode '0644'
  variables(cookbook_name: cookbook_name)
end

template "#{conf_dir}/application-users.properties" do
  source 'application-users.properties.erb'
  owner node['rackspace_jboss']['jboss_user']
  mode '0644'
  variables(cookbook_name: cookbook_name)
end

service 'jboss' do
  supports status: true, restart: true, reload: false
  action   [:enable, :start]
end
