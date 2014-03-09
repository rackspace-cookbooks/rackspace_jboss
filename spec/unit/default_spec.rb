require 'spec_helper'

describe 'rackspace_jboss::default' do
  context 'JBoss v7.1.1' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'installs and sets up java from java cookbook' do
      expect(chef_run).to include_recipe('java')
      expect(chef_run).to create_directory('/etc/profile.d')
      expect(chef_run).to create_file('/etc/profile.d/jdk.sh')
      expect(chef_run).to run_ruby_block('set-env-java-home')
    end

    it 'downloads the Jboss tarball' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.1.1.Final.tar.gz')
    end

    it 'creates the JBoss user, and directory' do
      expect(chef_run).to create_user(chef_run.node['rackspace_jboss']['jboss_user'])
      expect(chef_run).to create_directory(chef_run.node['rackspace_jboss']['jboss_home']).with(
        user:  chef_run.node['rackspace_jboss']['jboss_user'],
        mode:  '0755'
      )
    end

    it 'deploys JBoss' do
      expect(chef_run).to run_bash('deploy_jboss').with(cwd: chef_run.node['rackspace_jboss']['jboss_home'])
    end
  end

  context 'JBoss v7.1.0' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['rackspace_jboss']['jboss_version'] = '7.1.0'
      end.converge(described_recipe)
    end

    it 'downloads the JBoss 7.1.0 tarball' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.1.0.Final.tar.gz')
    end
  end

  context 'JBoss v7.0.0' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['rackspace_jboss']['jboss_version'] = '7.0.0'
      end.converge(described_recipe)
    end

    it 'downloads the JBoss 7.0.0 tarball' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.0.0.Final.tar.gz')
    end
  end
end
