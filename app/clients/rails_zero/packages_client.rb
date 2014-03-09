require_dependency "rails_zero/base_client"

module RailsZero
  class PackagesClient < BaseClient
    def get
      remote_url = File.join(RailsZero.pages_config.url, packages_path)
      destination = Rails.root.join('tmp', 'downloads', 'public.tar')
      FileUtils.mkdir_p(File.dirname(destination))
      command = "curl #{remote_url} > #{destination}"
      stdout_str, stderr_str, status = Open3.capture3(command)
    end
  end
end