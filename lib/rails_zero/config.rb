module RailsZero
  class Config
    attr_accessor :url, :git_remote_url, :git_binary

    def url
      @url ||= 'http://localhost:3000'
    end

    def links
      @links ||= []
    end

    def paths_to_except_from_cleanup
      @paths_to_except_from_cleanup ||= begin
        %w[ 404.html 422.html 500.html favicon.ico ].map do |f|
          Rails.root.join('public', f).to_s
        end
      end
    end

    def git_binary
      @git_binary ||= File.expand_path(File.join('..', '..', '..', 'bin', 'git'), __FILE__)
    end
  end
end
