module RailsZero
  class GenerateSiteJob
    include RailsZero::Engine.routes.url_helpers

    def run
      Capybara.app_host = RailsZero.config.backend.url
      Capybara.visit packages_new_path
      RailsZero.config.site.paths.each do |path|
        Capybara.visit path
      end
    end
  end
end
