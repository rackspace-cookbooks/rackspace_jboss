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

case node['rackspace_jboss']['jboss_version']
when '7.1.1'
  remote_file "#{Chef::Config[:file_cache_path]}/jboss-as-7.1.1.Final.tar.gz" do
    source 'http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz'
    action :create_if_missing
  end

when '7.1.0'
  remote_file "#{Chef::Config[:file_cache_path]}/jboss-as-7.1.0.Final.tar.gz" do
    source 'http://download.jboss.org/jbossas/7.1/jboss-as-7.1.0.Final/jboss-as-7.1.0.Final.tar.gz'
    action :create_if_missing
  end
end
