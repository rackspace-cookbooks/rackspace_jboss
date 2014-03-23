rackspace_jboss Cookbook
================

Installs and configures JBoss AS >= 7.0.0.


Requirements
------------
### Platforms
Tested on:
- RedHat 6.4
- CentOS 6.4

Attributes
----------

### default

* `node['rackspace_jboss']['jboss_home']` - jboss user home, default `/opt/jboss`
* `node['rackspace_jboss']['jboss_user']` - jboss user name, default `jboss`
* `node['rackspace_jboss']['jboss_uid']` - Lets you hard set the jboss user's uid instead of letting the system assign it, default `nil`
* `node['rackspace_jboss']['jboss_version']` - Version of jboss to download install.  Should work with 7.*, default `7.1.1`
* `node['rackspace_jboss']['jboss_type']` - Currently only supports standalone, future versions will include domain, default `standalone`
* `node['rackspace_jboss']['jboss_xml_file']` - Which XML file to use when starting jboss.  Only standalone.xml is supported at this time, default `standalone.xml`
* `node['rackspace_jboss']['jboss_as_conf']['dir']` - Directory to store jboss_as.conf file, default `/etc/jboss`
* `node['rackspace_jboss']['config']['jboss_as_conf']` - The full location to the jboss_as.conf file, default `/etc/jboss/jboss-as.conf`
* `node['rackspace_jboss']['config']['public_listen_address']` - Public interface binding, default `0.0.0.0`
* `node['rackspace_jboss']['config']['management_listen_address']` - Management interface binding, default `0.0.0.0`

### app_users

These are arrays that contain a hashed array of a user and a hash, i.e.:
{ '<user1>' => '<hash1>', '<user2>' => '<hash2>', etc.. }
To find the hash for a given user, either look it up in the
mgmt-users.properties and/or application-users.properties file on an
existing system, or run the following from a bash command line:
`python -c "import hashlib; print(hashlib.md5(b'<username>:ManagementRealm:<password>').hexdigest())"`
`python -c "import hashlib; print(hashlib.md5(b'<username>:ApplicationRealm:<password>').hexdigest())"`

* `node['rackspace_jboss']['config']['mgmt-users']` - default `{}`
* `node['rackspace_jboss']['config']['application-users']` - default `{}`

### java_opts

Given `['rackspace_jboss']['JAVA_OPTS']['set'][<name>] = <value>`
name is arbitrary, value needs to be the full command line switch.
The values will get packed into an array in rackspace_jboss::default
Then added into the standalone.conf file via template.

* `node['rackspace_jboss']['JAVA_OPTS']['set']['xms']` - Sets Xms, default `'-Xms64m'`
* `node['rackspace_jboss']['JAVA_OPTS']['set']['xmx']` - Sets Xmx, default `'-Xmx512m'`
* `node['rackspace_jboss']['JAVA_OPTS']['set']['max_perm_size']` - Sets MaxPermSize, default `'-XX:MaxPermSize=256m'`
* `node['rackspace_jboss']['JAVA_OPTS']['set']['pref_ipv4']` - Sets IPv4 Pref, default `'-Djava.net.preferIPv4Stack=true'`
* `node['rackspace_jboss']['JAVA_OPTS']['set']['resolver_warn']` - Sets jboss resolver warnings, default `'-Dorg.jboss.resolver.warning=true'`
* `node['rackspace_jboss']['JAVA_OPTS']['set']['client_gcinterval']` - Sets client GC interval, default `'-Dsun.rmi.dgc.client.gcInterval=3600000'`
* `node['rackspace_jboss']['JAVA_OPTS']['set']['server_gcinterval']` - Sets server GC interval , default `'-Dsun.rmi.dgc.server.gcInterval=3600000'`
* `node['rackspace_jboss']['config']['JAVA_OPTS']` - Array initializer to store final java_opts list

Recipes
-------

### default

Only recipe, will download, and deploy specified version of JBoss and Java, as well as setup options outlined in the Attributes.

Usage
-----

Either Download the recipe, and modify the attributes to your needs, or include the recipe, and set your overrides on the attributes.

### Examples

Grab JBoss 7.0.0, and set it up with openjdk 6:

````ruby
name "jboss-server"
run_list("recipe[rackspace_jboss]")
override_attributes(
  'rackspace_jboss' => {
    'jboss_version' => "7.0.0"
  }
  'java' => {
    'install_flavor' => "openjdk"
    'jdk_version' => "6"
  }
)

Setup as default, but override -Xms and -Xmx:

name "jboss-server"
run_list("recipe[rackspace_jboss]")
override_attributes(
  'rackspace_jboss' => {
    'JAVA_OPTS' => {
      'set' => {
        'xms' => '-Xms4G'
        'xmx' => '-Xmx4G'
      }
    }
  }
)

Testing
=======

Pleas see testing guidelines at [contributing](https://github.com/rackspace-cook
books/contributing/blob/master/CONTRIBUTING.md)

Contributing
============

Please see contributing guidelines at [contributing](https://github.com/rackspac
e-cookbooks/contributing/blob/master/CONTRIBUTING.md)

License & Authors
-----------------
- Author:: Jason Nelson (<jason.nelson@rackspace.com>)

```text
Copyright:: 2014, Rackspace, US Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
