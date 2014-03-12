module RailsZero
  class Config
    class Backend
      attr_accessor :url

      def url
        @url ||= 'http://localhost:3000'
      end
    end

    class GitDeployment
      attr_accessor :url,
                    :git_binary

      def git_binary
        @git_binary ||=
          File.expand_path(File.join('..', '..', '..', 'bin', 'git'), __FILE__)
      end
    end

    class Site
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
    end

    attr_reader :backend,
                :deployment,
                :site

    def initialize
      @backend = Backend.new
      @deployment = GitDeployment.new
      @site = Site.new
    end
  end
end
