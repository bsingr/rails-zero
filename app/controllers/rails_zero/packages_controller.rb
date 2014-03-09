require_dependency "rails_zero/application_controller"

module RailsZero
  class PackagesController < ApplicationController
    def index
      FileUtils.mkdir_p(File.dirname(archive_path))
      command = "tar -cf '#{archive_path}' '#{public_path}/'"
      stdout_str, stderr_str, status = Open3.capture3(command)
      send_file archive_path
    end

    def new
      CleanSiteJob.new.run
      head :ok
    end

  private

    def public_path
      Rails.root.join('public')
    end

    def archive_path
      Rails.root.join('tmp', 'packages', 'public.tar')
    end
  end
end
