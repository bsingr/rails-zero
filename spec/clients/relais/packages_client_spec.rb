require 'spec_helper'
require 'capybara/rails'
require 'rubygems/package'

module Relais
  describe PackagesClient do
    let('download_path') { Rails.root.join('tmp', 'downloads', 'public.tar') }
    before do
      File.exists?(download_path) && File.delete(download_path)
    end

    it "gets packages" do
      s = Capybara::Server.new(Capybara.app).boot
      subject.get "http://#{s.host}:#{s.port}"
      File.exists?(download_path).should be_true
      paths = []
      Gem::Package::TarReader.new(File.new(download_path)) do |tar|
        tar.each do |tarfile|
          paths << tarfile.full_name
        end
      end
      paths.should_not be_empty
    end
  end
end
