require "rails_zero/engine"
require "rails_zero/pages_config"
require 'actionpack/page_caching/railtie'
require 'open3'

module RailsZero
  def self.configure_pages
    yield pages_config
  end

  def self.pages_config
    @config ||= PagesConfig.new
  end
end
