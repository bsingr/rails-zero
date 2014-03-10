module RailsZero
  class GenerateSiteJob
    def run
      Capybara.app_host = RailsZero.pages_config.url
      RailsZero.pages_config.links.each do |path|
        Capybara.visit path
      end
      Capybara.reset_sessions!
    end
  end
end
