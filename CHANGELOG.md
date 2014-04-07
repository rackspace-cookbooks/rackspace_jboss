rackspace_jboss CHANGELOG
=========================

This file is used to list changes made in each version of the rackspace_jboss cookbook.

0.4.0
-----
- Move from java to rackspace_java

0.3.1
-----
- Only a version bump

0.3.0
-----
- mysql_jdbc integration

0.2.0
-----
- Production ready
- standalone.conf file managed by chef, supports custom JAVA_OPTS
- Testing fully passing

0.1.1
-----
- Change the jboss user to a system user, and provide option to change UID
- Now supporting users defined in users.rb attribute file
- Added templating to standalone.xml to set bind addresses
- Added startup script and jboss_as.conf files
- Installs java, options set in attributes/default.rb
- Downloads, deploys, sets up jboss user

0.1.0
-----
- Initial release of rackspace_jboss
