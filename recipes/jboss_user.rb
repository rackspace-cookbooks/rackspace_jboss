#
# Cookbook Name:: rackspace_jboss
# Recipe:: jboss_user
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
user node['rackspace_jboss']['jboss_user'] do
  home     node['rackspace_jboss']['jboss_home']
  shell    '/bin/bash'
  system   true
  supports manage_home: true
  if node['rackspace_jboss']['jboss_uid']
    uid node['rackspace_jboss']['jboss_uid']
  end
end
