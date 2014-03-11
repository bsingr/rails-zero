require 'spec_helper'

describe RailsZero::GenerateSiteJob do
  let('old_file') { Rails.root.join('public', 'deploy', 'some_file').to_s }
  let('html_file') { Rails.root.join('public', 'deploy', 'examples', "cached.html").to_s }
  let('json_file') { Rails.root.join('public', 'deploy', 'examples', "cached.json").to_s }
  let('server') { Capybara::Server.new(Capybara.app).boot }
  let('url') { "http://#{server.host}:#{server.port}" }
  before do
    ::CacheHelper.clean
  end
  after do
    ::CacheHelper.clean
  end

  it 'queries all pages' do
    Capybara.current_driver = :rack_test
    subject.run
    File.exists?(html_file).should be_true
    File.exists?(json_file).should be_false
  end

  it 'executes javascript with poltergeist' do
    RailsZero.config.backend_url = url
    Capybara.current_driver = :poltergeist
    subject.run
    File.exists?(html_file).should be_true
    File.exists?(json_file).should be_true
  end

  it 'cleans the cache' do
    FileUtils.mkdir_p(File.dirname(old_file))
    File.open(old_file, 'w') { |f| f.puts 'some old file' }
    subject.run
    File.exists?(old_file).should be_false
  end
end
