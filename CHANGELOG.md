rackspace_jboss CHANGELOG
=========================

This file is used to list changes made in each version of the rackspace_jboss cookbook.

0.5.1
-----
- Fixed a line that was still using ['jboss_home']/jboss-as-#{vers} instead of ['jboss_install_path']

0.5.0
-----
- Massive refactor for readability's sake
- Added guards in all template resources to not run if the configuration is coming from another source, like SVN or git
- Added jboss_install_path attribute to handle existing jboss layouts that stray from how this cookbook expects.
- Added testing around all additions, as well as added actual testing within kitchen runs.

0.4.2
-----
- Refactored how the jboss_user homedir is being handled

0.4.1
-----
- Jenkins tagged

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
