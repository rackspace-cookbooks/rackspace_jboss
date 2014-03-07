name             	'rackspace_jboss'
maintainer       	'Rackspace, US Inc.'
maintainer_email 	'rackspace-cookbooks@rackspace.com'
license          	'Apache 2.0'
description      	'Installs and Configures JBoss'
long_description 	IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          	'0.1.0'

recipe 				'rackspace_jboss',		'Installs and configures JBoss'

supports			'redhat', '>=6.3'
supports			'centos', '>=6.3'