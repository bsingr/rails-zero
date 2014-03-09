module RailsZero
  class PagesConfig
    attr_accessor :url

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
  end
end
