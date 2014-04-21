name             	'rackspace_jboss'
maintainer       	'Rackspace, US Inc.'
maintainer_email 	'rackspace-cookbooks@rackspace.com'
license          	'Apache 2.0'
description      	'Installs and Configures JBoss'
long_description 	IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          	'0.4.3'

recipe 				'rackspace_jboss',		'Downloads and deploys JBoss, adds jboss user'

supports			'redhat', '>= 6.3'
supports			'centos', '>= 6.3'

depends				'rackspace_java', '~> 2.0'
