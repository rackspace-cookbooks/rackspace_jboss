require 'spec_helper'

describe 'rackspace_jboss::default' do
  context 'JBoss v7.1.1' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'downloads the Jboss tarball' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.1.1.Final.tar.gz')
    end

    it 'creates the JBoss user, group, and directory' do
      expect(chef_run).to create_user('jboss')
      expect(chef_run).to create_directory('/opt/jboss').with(
        user:  'jboss',
        mode:  '0755'
      )
    end

    it 'deploys JBoss' do
      expect(chef_run).to run_bash('deploy_jboss').with(cwd: '/opt/jboss')
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
