require_dependency "relais/base_client"

module Relais
  class PackagesClient < BaseClient
    def get url
      remote_url = File.join(url, packages_path)
      destination = Rails.root.join('tmp/public.tar')
      Kernel.system "curl #{remote_url} > #{destination}"
    end
  end
end