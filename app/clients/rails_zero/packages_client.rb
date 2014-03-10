require_dependency "rails_zero/base_client"

module RailsZero
  class PackagesClient < BaseClient
    def download_destination
      Rails.root.join('tmp', 'rails_zero', 'downloads', 'public.tar').to_s
    end

    def get
      remote_url = File.join(RailsZero.config.url, packages_path)
      FileUtils.mkdir_p(File.dirname(download_destination))
      command = "curl #{remote_url} > #{download_destination}"
      stdout_str, stderr_str, status = Open3.capture3(command)
    end
  end
end