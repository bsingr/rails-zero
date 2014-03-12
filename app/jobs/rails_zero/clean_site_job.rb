module RailsZero
  class CleanSiteJob
    def run
      Dir[Rails.root.join('public', '**', '*').to_s].each do |f|
        if !excluded_files.include?(f) && File.exists?(f)
          FileUtils.rm_rf(f)
        end
      end
    end

  private

    def excluded_files
      RailsZero.config.site.paths_to_except_from_cleanup
    end
  end
end
