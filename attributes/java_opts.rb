#
# Cookbook Name:: rackspace_jboss
# Attributes:: java_opts
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

# Given ['rackspace_jboss']['JAVA_OPTS']['set'][<name>] = <value>
# name is arbitrary, value needs to be the full command line switch.
# The values will get packed into an array in rackspace_jboss::default
# Then added into the standalone.conf file via template.
default['rackspace_jboss']['JAVA_OPTS']['set']['xms']                = '-Xms64m'
default['rackspace_jboss']['JAVA_OPTS']['set']['xmx']                = '-Xmx512m'
default['rackspace_jboss']['JAVA_OPTS']['set']['max_perm_size']      = '-XX:MaxPermSize=256m'
default['rackspace_jboss']['JAVA_OPTS']['set']['pref_ipv4']          = '-Djava.net.preferIPv4Stack=true'
default['rackspace_jboss']['JAVA_OPTS']['set']['resolver_warn']      = '-Dorg.jboss.resolver.warning=true'
default['rackspace_jboss']['JAVA_OPTS']['set']['client_gcinterval']  = '-Dsun.rmi.dgc.client.gcInterval=3600000'
default['rackspace_jboss']['JAVA_OPTS']['set']['server_gcinterval']  = '-Dsun.rmi.dgc.server.gcInterval=3600000'

default['rackspace_jboss']['config']['JAVA_OPTS'] = []
