require 'spec_helper'
require 'capybara/rails'

module Relais
  describe PackagesClient do
    let('download_path') { Rails.root.join('tmp/public.tar') }
    before do
      File.exists?(download_path) && File.delete(download_path)
    end

    it "gets packages" do
      s = Capybara::Server.new(Capybara.app).boot
      subject.get "http://#{s.host}:#{s.port}"
      File.exists?(download_path).should be_true
    end
  end
end
