require 'spec_helper'

describe Relais::CleanSiteJob do
  let('file_path') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  before do
    FileUtils.touch(file_path)
  end
  after do
    if File.exists?(file_path)
      File.delete(file_path)
    end
  end
  it 'queries all pages' do
    File.exists?(file_path).should be_true
    subject.run
    File.exists?(file_path).should be_false
    File.exists?(Rails.root.join('public', '404.html').to_s).should be_true
    File.exists?(Rails.root.join('public', '422.html').to_s).should be_true
    File.exists?(Rails.root.join('public', '500.html').to_s).should be_true
    File.exists?(Rails.root.join('public', 'favicon.ico').to_s).should be_true
  end
end
