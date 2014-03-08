require "relais/engine"
require "relais/pages_config"

module Relais
  def self.configure_pages
    yield pages_config
  end

  def self.pages_config
    @config ||= PagesConfig.new
  end
end
