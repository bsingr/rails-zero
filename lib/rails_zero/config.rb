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
      attr_writer :paths, :paths_builders

      def paths
        paths = []
        paths.concat(@paths) if defined?(@paths)
        paths.concat(map_paths_from_paths_builders)
        paths.flatten
      end

      def add_paths paths
        @paths ||= []
        @paths << paths
      end

      def add_path path
        @paths ||= []
        @paths << path
      end

      def define_lazy_paths &block
        @lazy_paths = block
      end

      def paths_to_except_from_cleanup
        @paths_to_except_from_cleanup ||= begin
          %w[ 404.html
              422.html
              500.html
              favicon.ico
              ].map do |f|
            Rails.root.join('public', f).to_s
          end
        end
      end

    private

      def map_paths_from_paths_builders
        if defined? @paths_builders
          @paths_builders.map{|b| b.call}
        else
          []
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
