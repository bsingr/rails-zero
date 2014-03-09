require 'spec_helper'

describe RailsZero::GenerateSiteJob do
  let('path') { '/examples/cached' }
  let('file_path') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  before do
    ::CacheHelper.clean
  end
  after do
    ::CacheHelper.clean
  end
  it 'queries all pages' do
    RailsZero.configure_pages do |c|
      c.links << path
    end
    subject.run
    File.exists?(file_path).should be_true
  end
end
