require 'spec_helper'

describe RailsZero::GenerateSiteJob do
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
    RailsZero.pages_config.url = url
    Capybara.current_driver = :poltergeist
    subject.run
    File.exists?(html_file).should be_true
    File.exists?(json_file).should be_true
  end
end
