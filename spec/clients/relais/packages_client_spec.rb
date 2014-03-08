require 'spec_helper'
require 'capybara/rails'

module Relais
  describe PackagesClient do
    let('download_path') { Rails.root.join('tmp', 'downloads', 'public.tar') }
    let('server') { Capybara::Server.new(Capybara.app).boot }
    let('url') { "http://#{server.host}:#{server.port}" }
    
    before do
      File.exists?(download_path) && File.delete(download_path)
    end

    after do
      Dir[Rails.root.join('public', '*.rspec')].each do |f|
        File.delete(f)
      end
    end

    it "gets packages" do
      example_path = Rails.root.join('public', "#{Time.now.to_i}.rspec").to_s
      File.open(example_path, "w") do |f|
        f.puts "example"
      end
      subject.get url
      File.exists?(download_path).should be_true
      paths = ::TarHelper.read(download_path)
      paths.should_not be_empty
      paths.map{|p| File.basename(p)}.should include(File.basename(example_path))
    end
  end
end
