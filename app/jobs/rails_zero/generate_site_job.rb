module RailsZero
  class GenerateSiteJob
    def run
      Capybara.app_host = RailsZero.config.url
      RailsZero.config.links.each do |path|
        Capybara.visit path
      end
      Capybara.reset_sessions!
    end
  end
end
