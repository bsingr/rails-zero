require 'spec_helper'
require 'capybara/rails'

module RailsZero
  describe PackagesClient do
    let('download_path') { Rails.root.join('tmp', 'rails_zero', 'downloads', 'public.tar').to_s }
    let('server') { Capybara::Server.new(Capybara.app).boot }
    let('url') { "http://#{server.host}:#{server.port}" }
    
    before do
      RailsZero.config.url = url
    end

    before do
      FileUtils.rm_rf(download_path)
    end

    after do
      ::CacheHelper.clean
    end

    its('download_destination') { should == download_path }

    it "gets packages" do
      example_path = Rails.root.join('public', "#{Time.now.to_i}.rspec").to_s
      File.open(example_path, "w") do |f|
        f.puts "example"
      end
      subject.get
      File.exists?(download_path).should be_true
      paths = ::TarHelper.read(download_path)
      paths.should_not be_empty
      paths.map{|p| File.basename(p)}.should include(File.basename(example_path))
    end
  end
end
