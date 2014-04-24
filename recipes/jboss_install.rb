#
# Cookbook Name:: rackspace_jboss
# Recipe:: jboss_install
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
vers     = node['rackspace_jboss']['jboss_version']
mmvers   = vers.split('.')[0] + '.' + vers.split('.')[1]
bin_dir  = "#{node['rackspace_jboss']['jboss_install_path']}/bin"

remote_file "#{Chef::Config[:file_cache_path]}/jboss-as-#{vers}.tar.gz" do
  source "http://download.jboss.org/jbossas/#{mmvers}/jboss-as-#{vers}/jboss-as-#{vers}.tar.gz"
  action :create_if_missing
end

bash 'deploy_jboss' do
  not_if { File.exist?("#{bin_dir}/standalone.sh") }
  user node['rackspace_jboss']['jboss_user']
  cwd  node['rackspace_jboss']['jboss_home']
  code <<-EOH
    tar zxf #{Chef::Config[:file_cache_path]}/jboss-as-#{vers}.tar.gz
  EOH
end
