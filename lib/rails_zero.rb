require "rails_zero/engine"
require "rails_zero/config"
require 'actionpack/page_caching/railtie'
require 'capybara/dsl'
require 'open3'

module RailsZero
  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end

  def self.path *args
    File.expand_path(File.join('..', '..', *args), __FILE__)
  end
end
