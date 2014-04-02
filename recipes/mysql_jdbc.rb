#
# Cookbook Name:: rackspace_jboss
# Recipe:: mysql_jdbc
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

# In case the recipe is called directly rather than overriding the attribute.
node.set['rackspace_jboss']['mysql_jdbc']['enabled'] = true

include_recipe 'rackspace_jboss::default'

vers        = node['rackspace_jboss']['jboss_version']
install_dir = "#{node['rackspace_jboss']['jboss_home']}/jboss-as-#{vers}.Final/modules/com/mysql/main"
curver      = `curl -s http://dev.mysql.com/downloads/connector/j/ | egrep 'Connector' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+'`.delete("\n") # ~FC048

if node['rackspace_jboss']['mysql_jdbc']['version'] == 'current'
  node.set['rackspace_jboss']['mysql_jdbc']['version'] = curver
end

jar_file    = "mysql-connector-java-#{node['rackspace_jboss']['mysql_jdbc']['version']}-bin.jar"
tar_file    = "mysql-connector-java-#{node['rackspace_jboss']['mysql_jdbc']['version']}.tar.gz"
current_url = "http://cdn.mysql.com/Downloads/Connector-J/#{tar_file}"
archive_url = "http://cdn.mysql.com/archives/mysql-connector-java-5.1/#{tar_file}"

remote_file "#{Chef::Config[:file_cache_path]}/#{tar_file}" do
  if node['rackspace_jboss']['mysql_jdbc']['version'] == curver
    source current_url
  else
    source archive_url
  end
  action :create_if_missing
end

directory install_dir do
  owner     node['rackspace_jboss']['jboss_user']
  mode      '0755'
  recursive true
  action    :create
end

bash 'deploy_mysql_jdbc' do
  not_if { File.exist?("#{install_dir}/#{jar_file}") }
  user node['rackspace_jboss']['jboss_user']
  cwd  install_dir
  code <<-EOH
    tar --strip-components=1 -zxf\
    #{Chef::Config[:file_cache_path]}/#{tar_file}\
    mysql-connector-java-#{node['rackspace_jboss']['mysql_jdbc']['version']}/#{jar_file}
  EOH
end

template "#{install_dir}/module.xml" do
  source    'mysql_jdbc_module.xml.erb'
  owner     node['rackspace_jboss']['jboss_user']
  mode      '0644'
  variables(cookbook_name: cookbook_name)
  notifies  :restart, 'service[jboss]'
end
