require 'spec_helper'

describe RailsZero::Config do
  its('site.paths') { should == [] }
  its('site.paths_to_except_from_cleanup') { should == [
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
  its('deployment.git_binary') { should == File.expand_path(File.join('..', '..', '..', '..', 'bin', 'git'), __FILE__) }
  its('deployment.url') { should == nil }

  describe '.paths' do
    it 'accepts procs that return strings' do
      subject.site.paths_builders = [->{'/foo'}]
      subject.site.paths.should == %w[ /foo ]
    end

    it 'accepts procs that return arrays' do
      subject.site.paths_builders = [->{%w[ /foo /bar ]}]
      subject.site.paths.should == %w[ /foo /bar ]
    end

    it 'accepts strings' do
      subject.site.paths = %w[ /foo ]
      subject.site.paths.should == %w[ /foo ]
    end

    it 'accepts strings and procs' do
      subject.site.paths = %w[ /foo /bar ]
      subject.site.paths_builders = [->{'/baz'}]
      subject.site.paths.should == %w[ /foo /bar /baz ]
    end
  end
end
