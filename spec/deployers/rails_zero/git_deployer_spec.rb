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

  its('git_binary') { should == RailsZero.config.git_binary }
  its('git_remote_url') { should == RailsZero.config.git_remote_url }
  its('package_path') { should == download_destination }
  its('extracted_package_path') { should == extracted_package_path }

  it 'extract_package' do
    FileUtils.cp(AssetsHelper.path('example.tar'), subject.package_path)
    subject.extract_package
    File.exists?(File.join(dir, 'example', 'example-file')).should be_true
  end

  it 'push_package' do
    ENV['RAILS_ZERO_GIT_DEPLOYER_SSH_KEY_CONTENT'] = 'foo'

    FileUtils.mkdir_p(git_remote_url)
    Dir.chdir(git_remote_url) { Open3.capture3('git init --bare') }
    RailsZero.config.git_remote_url = git_remote_url
    
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

  it 'removes, creates, extracts and pushs the package' do
    subject.should_receive(:remove_dir).ordered
    subject.should_receive(:create_dir).ordered
    subject.should_receive(:extract_package).ordered
    subject.should_receive(:push_package).ordered
    subject.run
  end
end
