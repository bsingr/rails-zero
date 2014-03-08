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

    it "gets packages" do
      subject.get url
      File.exists?(download_path).should be_true
      paths = ::TarHelper.read(download_path)
      paths.should_not be_empty
    end
  end
end
