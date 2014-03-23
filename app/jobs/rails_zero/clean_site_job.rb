module RailsZero
  class CleanSiteJob
    def run
      root = Rails.root.join('public').to_s
      Dir[File.join(root, '**', '*').to_s].each do |absolute_path|
        found_exclude = excluded_files.find do |excluded_path|
          if absolute_path.start_with?(excluded_path) && File.directory?(excluded_path)
            true
          else
            excluded_path == absolute_path
          end
        end
        is_excluded = found_exclude != nil
        FileUtils.rm_rf(absolute_path) unless is_excluded
      end
    end

  private

    def excluded_files
      RailsZero.config.site.paths_to_except_from_cleanup.map do |f|
        Rails.root.join('public', f).to_s
      end
    end
  end
end
