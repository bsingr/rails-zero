require_dependency "relais/base_client"

module Relais
  class PackagesClient < BaseClient
    def get
      Kernel.system "curl #{packages_path} > public.tar"
    end
  end
end