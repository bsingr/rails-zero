module RailsZero
  class CleanSiteJob
    def run
      root = Rails.root.join('public').to_s
      Dir[File.join(root, '**', '*').to_s].each do |f|
        relative_path = f.gsub(root, '')
        if !excluded_files.include?(relative_path) && File.exists?(f)
          FileUtils.rm_rf(f)
        end
      end
    end

  private

    def excluded_files
      RailsZero.config.site.paths_to_except_from_cleanup.map do |f|
        File.join('/', f)
      end
    end
  end
end
