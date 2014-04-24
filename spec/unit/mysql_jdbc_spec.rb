require 'spec_helper'

describe 'rackspace_jboss::mysql_jdbc' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  before :each do
    @vers = chef_run.node['rackspace_jboss']['jboss_version']
    @install_dir = "#{chef_run.node['rackspace_jboss']['jboss_install_path']}/modules/com/mysql/main"
  end

  it 'creates the mysql/main subdirectory' do
    expect(chef_run).to create_directory(@install_dir)
  end

  it 'deploys mysql_jdbc' do
    expect(chef_run).to run_bash('deploy_mysql_jdbc').with(cwd: @install_dir)
  end

  it 'creates the module.xml file from template' do
    expect(chef_run).to create_template(@install_dir + '/module.xml')
    expect(chef_run).to render_file(@install_dir + '/module.xml').with_content('com.mysql')
  end

  context 'downloads current version of mysql_jdbc' do
    it 'downloads the mysql_jdbc tarball' do
      chef_run.node.set['rackspace_jboss']['mysql_jdbc']['version'] =
        `curl -s http://dev.mysql.com/downloads/connector/j/ | egrep 'Connector' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+'`.delete("\n")
      chef_run.converge(described_recipe)
      tar_file = "mysql-connector-java-#{chef_run.node['rackspace_jboss']['mysql_jdbc']['version']}.tar.gz"
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + "/#{tar_file}")
    end
  end

  context 'downloads a previous version of mysql_jdbc' do
    it 'downloads the mysql_jdbc tarball' do
      chef_run.node.set['rackspace_jboss']['mysql_jdbc']['version'] = '5.1.25'
      chef_run.converge(described_recipe)
      tar_file = "mysql-connector-java-#{chef_run.node['rackspace_jboss']['mysql_jdbc']['version']}.tar.gz"
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + "/#{tar_file}")
    end
  end
end
