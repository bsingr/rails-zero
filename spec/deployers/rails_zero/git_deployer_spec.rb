require 'spec_helper'

describe RailsZero::GitDeployer do
  let('dir') { Rails.root.join('tmp', 'rails_zero', 'deploy').to_s }
  let('download_destination') { RailsZero::PackagesClient.new.download_destination }
  let('extracted_package_path') { File.join(dir, File.basename(download_destination, File.extname(download_destination))) }
  let('git_remote_url') { Rails.root.join('tmp', 'rspec', 'git_remote.git').to_s }

  before do
    FileUtils.rm_rf(dir)
  end

  its('dir') { should == dir }

  it 'remove_dir' do
    FileUtils.mkdir_p(dir)
    subject.remove_dir
    File.exists?(dir).should be_false
  end

  it 'create_dir' do
    subject.create_dir
    File.exists?(dir).should be_true
  end

  its('git_binary') { should == RailsZero.config.deployment.git_binary }
  its('git_remote_url') { should == RailsZero.config.deployment.url }
  its('package_path') { should == download_destination }
  its('extracted_package_path') { should == extracted_package_path }

  it 'extract_package' do
    FileUtils.mkdir_p(dir)
    TarHelper.create(subject.package_path, AssetsHelper.path('public'))
    subject.extract_package
    File.exists?(File.join(dir, 'public', 'index.html')).should be_true
    File.exists?(extracted_package_path).should be_true
  end

  it 'raise error on extract_package' do
    FileUtils.rm_rf(subject.package_path)
    expect{ subject.extract_package }.to raise_error(RailsZero::MissingPackageError)
  end

  it 'push_package' do
    ENV['RAILS_ZERO_GIT_DEPLOYER_SSH_KEY_CONTENT'] = 'foo'

    FileUtils.mkdir_p(git_remote_url)
    Dir.chdir(git_remote_url) { Open3.capture3('git init --bare') }
    RailsZero.config.deployment.url = git_remote_url
    
    FileUtils.mkdir_p(extracted_package_path)
    File.open(File.join(extracted_package_path, 'example-file'), 'w') do |f|
      f.puts 'example content'
    end
    subject.push_package
    
    Dir.chdir(git_remote_url) do
      stdout_str, stderr_str, status = Open3.capture3('git log -p')
      stdout_str.should include('Deploy.')
      stdout_str.should include('example-file')
      stdout_str.should include('example content')
    end
  end

  it 'raise error on push_package' do
    FileUtils.rm_rf(extracted_package_path)
    expect{ subject.push_package }.to raise_error(RailsZero::Error)
  end

  it 'raise git error on push_package' do
    RailsZero.config.deployment.url = 'http://example.com'
    FileUtils.rm_rf(extracted_package_path)
    FileUtils.mkdir_p(extracted_package_path)
    expect{ subject.push_package }.to raise_error(RailsZero::GitError)
  end

  it 'removes, creates, extracts and pushs the package' do
    subject.should_receive(:remove_dir).ordered
    subject.should_receive(:create_dir).ordered
    subject.should_receive(:extract_package).ordered
    subject.should_receive(:push_package).ordered
    subject.run
  end
end
