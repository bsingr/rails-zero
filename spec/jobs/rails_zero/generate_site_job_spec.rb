require 'spec_helper'

describe RailsZero::GenerateSiteJob do
  let('file_path') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  before do
    ::CacheHelper.clean
  end
  after do
    ::CacheHelper.clean
  end
  it 'queries all pages' do
    subject.run
    File.exists?(file_path).should be_true
  end
end
