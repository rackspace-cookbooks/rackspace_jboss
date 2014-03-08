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

vers = node['rackspace_jboss']['jboss_version']
mmvers = vers.split('.')[0] + '.' + vers.split('.')[1]

remote_file "#{Chef::Config[:file_cache_path]}/jboss-as-#{vers}.Final.tar.gz" do
  source "http://download.jboss.org/jbossas/#{mmvers}/jboss-as-#{vers}.Final/jboss-as-#{vers}.Final.tar.gz"
  action :create_if_missing
end

user node['rackspace_jboss']['jboss_user'] do
  home node['rackspace_jboss']['jboss_home']
  shell '/bin/false'
end

directory node['rackspace_jboss']['jboss_home'] do
  owner node['rackspace_jboss']['jboss_user']
  mode '0755'
  action :create
end

bash 'deploy_jboss' do
  not_if { File.exists?("#{node['rackspace_jboss']['jboss_home']}/jboss-as-#{vers}.Final/bin/standalone.sh") }
  user node['rackspace_jboss']['jboss_user']
  cwd  node['rackspace_jboss']['jboss_home']
  code <<-EOH
    tar zxf #{Chef::Config[:file_cache_path]}/jboss-as-#{vers}.Final.tar.gz
  EOH
end
