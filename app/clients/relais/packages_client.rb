require_dependency "relais/base_client"

module Relais
  class PackagesClient < BaseClient
    def get url
      remote_url = File.join(url, packages_path)
      destination = Rails.root.join('tmp', 'downloads', 'public.tar')
      FileUtils.mkdir_p(File.dirname(destination))
      command = "curl #{remote_url} > #{destination}"
      stdout_str, stderr_str, status = Open3.capture3(command)
    end
  end
end