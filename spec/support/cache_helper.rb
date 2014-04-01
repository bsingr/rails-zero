module CacheHelper
  def self.clean
    excluded_files = %w[ 404.html 422.html 500.html favicon.ico robots.txt].map do |f|
      Rails.root.join('public', f).to_s
    end
    Dir[Rails.root.join('public', '**', '*').to_s].each do |f|
      if !excluded_files.include?(f) && File.exists?(f)
        FileUtils.rm_rf(f)
      end
    end
  end
end
