module RailsZero
  class GenerateSiteJob
    def run
      RailsZero.pages_config.links.each do |path|
        Capybara.visit path
      end
    end
  end
end
