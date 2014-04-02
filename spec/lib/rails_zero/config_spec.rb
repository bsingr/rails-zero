require 'spec_helper'

describe RailsZero::Config do
  subject('config') { described_class.new }

  its('site.paths') { should == [] }
  its('site.paths_to_except_from_cleanup') { should == %w[ 404.html
                                                           422.html
                                                           500.html
                                                           favicon.ico
                                                           robots.txt
                                                           assets ] }
  its('backend.url') { should == 'http://localhost:3000' }
  it 'can change backend.url' do
    subject.backend.url = 'foo'
    subject.backend.url.should == 'foo'
  end
  its('deployment.git_binary') { should == File.expand_path(File.join('..', '..', '..', '..', 'bin', 'git'), __FILE__) }
  its('deployment.url') { should == nil }
  its('deployment.git_remote_ref') { should == 'master' }

  describe '.site' do
    subject('site') { config.site }

    it 'adds single path' do
      subject.add_path '/foo'
      subject.add_path '/bar'
      subject.paths.should == %w[ /foo /bar ]
    end

    it 'adds multiple paths' do
      subject.add_paths %w[ /foo ]
      subject.add_paths %w[ /bar /baz ]
      subject.paths.should == %w[ /foo /bar /baz ]
    end

    it 'accepts procs that return strings' do
      subject.paths_builders = [->{'/foo'}]
      subject.paths.should == %w[ /foo ]
    end

    it 'accepts procs that return arrays' do
      subject.paths_builders = [->{%w[ /foo /bar ]}]
      subject.paths.should == %w[ /foo /bar ]
    end

    it 'accepts strings' do
      subject.paths = %w[ /foo ]
      subject.paths.should == %w[ /foo ]
    end

    it 'accepts strings and procs' do
      subject.paths = %w[ /foo /bar ]
      subject.paths_builders = [->{'/baz'}]
      subject.paths.should == %w[ /foo /bar /baz ]
    end
  end
end
