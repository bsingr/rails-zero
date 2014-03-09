require_dependency "relais/application_controller"

module Relais
  class PackagesController < ApplicationController
    def index
      FileUtils.mkdir_p(File.dirname(archive_path))
      system "tar -cf '#{archive_path}' '#{public_path}/'"
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
