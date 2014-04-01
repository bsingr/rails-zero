require 'spec_helper'

describe RailsZero::CleanSiteJob do
  let('file_path') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  let('asset_path') { Rails.root.join('public', 'assets', 'example.txt').to_s }
  before do
    [file_path, asset_path].each do |p|
      FileUtils.rm_rf(p)
      FileUtils.mkdir_p(File.dirname(p))
      FileUtils.touch(p)
    end
  end
  after do
    [file_path, asset_path].each do |p|
      FileUtils.rm_rf(p)
    end
  end
  it 'queries all pages' do
    File.exists?(file_path).should be_true
    File.exists?(asset_path).should be_true
    subject.run
    File.exists?(file_path).should be_false
    File.exists?(asset_path).should be_true
    File.exists?(Rails.root.join('public', '404.html').to_s).should be_true
    File.exists?(Rails.root.join('public', '422.html').to_s).should be_true
    File.exists?(Rails.root.join('public', '500.html').to_s).should be_true
    File.exists?(Rails.root.join('public', 'favicon.ico').to_s).should be_true
    File.exists?(Rails.root.join('public', 'robots.txt').to_s).should be_true
  end
end
