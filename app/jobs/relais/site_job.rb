module Relais
  class SiteJob
    def run
      Relais.pages_config.links.each do |path|
        Capybara.visit path
      end
    end
  end
end
