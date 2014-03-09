$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_zero/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-zero"
  s.version     = RailsZero::VERSION
  s.authors     = ["Jens Bissinger"]
  s.email       = ["mail@jens-bissinger.de"]
  s.homepage    = "https://github.com/dpree/rails-zero"
  s.summary     = "RailsZero is a static site generator based on Rails"
  s.description = "RailsZero is a Rails Engine that helps generating static websites out of any Rails application."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency 'actionpack-page_caching'
  s.add_dependency 'capybara'


  s.add_development_dependency "sqlite3"
end
