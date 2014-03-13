require 'spec_helper'

describe 'rackspace_jboss::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs and sets up java from java cookbook' do
    expect(chef_run).to include_recipe('java')
    expect(chef_run).to create_directory('/etc/profile.d')
    expect(chef_run).to create_file('/etc/profile.d/jdk.sh')
    expect(chef_run).to run_ruby_block('set-env-java-home')
  end

  it 'creates the JBoss user, home directory, and config directory' do
    expect(chef_run).to create_user(chef_run.node['rackspace_jboss']['jboss_user'])
    expect(chef_run).to create_directory(chef_run.node['rackspace_jboss']['jboss_home']).with(
      user:  chef_run.node['rackspace_jboss']['jboss_user'],
      mode:  '0755'
    )
    expect(chef_run).to create_directory(chef_run.node['rackspace_jboss']['jboss_as_conf']['dir']).with(
      user:  'root',
      mode: '0755'
    )
  end

  it 'deploys JBoss' do
    expect(chef_run).to run_bash('deploy_jboss').with(cwd: chef_run.node['rackspace_jboss']['jboss_home'])
  end

  it 'creates the startup script from template' do
    expect(chef_run).to create_template('/etc/init.d/jboss')
    expect(chef_run).to render_file('/etc/init.d/jboss').with_content('JBoss standalone control script')
  end

  it 'creates the jboss_as conf file from template' do
    expect(chef_run).to create_template(chef_run.node['rackspace_jboss']['config']['jboss_as_conf'])
    expect(chef_run).to render_file(chef_run.node['rackspace_jboss']['config']['jboss_as_conf']).with_content('JBOSS_USER')
  end

  it 'enables and starts the JBoss service' do
    expect(chef_run).to enable_service('jboss')
    expect(chef_run).to start_service('jboss')
  end

  context 'JBoss v7.1.1' do
    it 'downloads the Jboss tarball' do
      chef_run.node.set['rackspace_jboss']['jboss_version'] = '7.1.1'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.1.1.Final.tar.gz')
    end
  end

  context 'JBoss v7.1.0' do
    it 'downloads the JBoss 7.1.0 tarball' do
      chef_run.node.set['rackspace_jboss']['jboss_version'] = '7.1.0'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.1.0.Final.tar.gz')
    end
  end

  context 'JBoss v7.0.0' do
    it 'downloads the JBoss 7.0.0 tarball' do
      chef_run.node.set['rackspace_jboss']['jboss_version'] = '7.0.0'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file_if_missing(Chef::Config['file_cache_path'] + '/jboss-as-7.0.0.Final.tar.gz')
    end
  end

  context 'Using OpenJDK 7' do
    it 'installs openJDK 7' do
      chef_run.node.override['java']['install_flavor'] = 'openjdk'
      chef_run.node.override['java']['jdk_version'] = '7'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('openjdk-7-jdk')
    end
  end

  context 'Using OpenJDK 6' do
    it 'installs openJDK 6' do
      chef_run.node.override['java']['install_flavor'] = 'openjdk'
      chef_run.node.override['java']['jdk_version'] = '6'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('openjdk-6-jdk')
    end
  end

  context 'Using Oracle Java 7' do
    it 'installs Oracle Java 7' do
      chef_run.node.override['java']['install_flavor'] = 'oracle'
      chef_run.node.override['java']['jdk_version'] = '7'
      chef_run.converge(described_recipe)
      pending 'Oracle Java is installed using an LWRP from the java cookbook, testing is complicated'
    end
  end

  context 'Using Oracle Java 6' do
    it 'installs Oracle Java 6' do
      chef_run.node.override['java']['install_flavor'] = 'oracle'
      chef_run.node.override['java']['jdk_version'] = '6'
      chef_run.converge(described_recipe)
      pending 'Oracle Java is installed using an LWRP from the java cookbook, testing is complicated'
    end
  end

end
