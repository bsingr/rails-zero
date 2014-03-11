require 'spec_helper'

describe RailsZero::Config do
  its('links') { should == [] }
  its('paths_to_except_from_cleanup') { should == [
    Rails.root.join('public/404.html').to_s,
    Rails.root.join('public/422.html').to_s,
    Rails.root.join('public/500.html').to_s,
    Rails.root.join('public/favicon.ico').to_s
  ] }
  its('backend.url') { should == 'http://localhost:3000' }
  it 'can change backend.url' do
    subject.backend.url = 'foo'
    subject.backend.url.should == 'foo'
  end
  its('git_binary') { should == File.expand_path(File.join('..', '..', '..', '..', 'bin', 'git'), __FILE__) }
end
