require 'spec_helper'

describe Relais::SiteJob do
  let('path') { '/examples/cached' }
  let('file_path') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  before do
    if File.exists?(file_path)
      File.delete(file_path)
    end
  end
  it 'queries all pages' do
    Relais.configure_pages do |c|
      c.links << path
    end
    subject.run
    File.exists?(file_path).should be_true
  end
end
