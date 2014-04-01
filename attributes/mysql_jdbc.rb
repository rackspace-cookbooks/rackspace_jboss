#
# Cookbook Name:: rackspace_jboss
# Attributes:: mysql_jdbc
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

default['rackspace_jboss']['mysql_jdbc']['enabled']                                       = false

# Set the version, either current to have most recent version, or lock
# in a version such as '5.1.29'.  Currently only supports 5.1 branch.
default['rackspace_jboss']['mysql_jdbc']['version']                                       = 'current'

default['rackspace_jboss']['mysql_jdbc']['jar_file']                                      =
  "mysql-connector-java-#{node['rackspace_jboss']['mysql_jdbc']['version']}-bin.jar"
default['rackspace_jboss']['mysql_jdbc']['tar_file']                                      =
  "mysql-connector-java-#{node['rackspace_jboss']['mysql_jdbc']['version']}.tar.gz"
default['rackspace_jboss']['mysql_jdbc']['current_url']                                   =
  "http://cdn.mysql.com/Downloads/Connector-J/#{node['rackspace_jboss']['mysql_jdbc']['tar_file']}"
default['rackspace_jboss']['mysql_jdbc']['archive_url']                                   =
  "http://cdn.mysql.com/archives/mysql-connector-java-5.1/#{node['rackspace_jboss']['mysql_jdbc']['tar_file']}"

default['rackspace_jboss']['mysql_jdbc']['datasource_name']                               = 'MySqlDS'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['hostname']                      = 'localhost'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['port']                          = '3306'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['dbname']                        = 'changeme'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['username']                      = 'changeme'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['password']                      = 'changeme'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['min_pool_size']                 = '10'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['max_pool_size']                 = '100'
default['rackspace_jboss']['mysql_jdbc']['mysql_server']['prepared_statement_cache_size'] = '32'
