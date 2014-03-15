[![Rails Zero](./resources/logo.png)](./resources/logo.png)

# Rails Zero

Static site generation the Rails way.

[![Build Status](https://travis-ci.org/dpree/rails-zero.png)](https://travis-ci.org/dpree/rails-zero)
[![Code Climate](https://codeclimate.com/github/dpree/rails-zero.png)](https://codeclimate.com/github/dpree/rails-zero)
[![Gem Version](https://badge.fury.io/rb/rails-zero.png)](http://badge.fury.io/rb/rails-zero)

## Getting Started

Add the following to the `Gemfile` of your Rails application:

    gem 'rails-zero'

Then run the generator:
  
    rails g rails_zero:install

This adds the following to your `config/routes.rb`:

    mount RailsZero::Engine => "/rails_zero"

And it adds an initializer to `config/initializers/rails_zero.rb`:

    # Enable the following support rendering requests triggered by javascript code:
    # require 'rails_zero/drivers/poltergeist'

    RailsZero.configure do |config|
      # Rails application is hosted at (default: http://localhost:3000)
      # config.backend.url = 'http://admin.example.com' if Rails.env.production?

      # Deployment target (e.g. a git repository url for gh-pages)
      # config.deployment.url = 'http://github.com/<you>/<gh-pages--enabled-repo>.git'

      # Paths that will be rendered and included in your site
      #
      # Add single paths:
      # config.site.add_path << '/example/foo'
      #
      # Add multiple paths at once:
      # config.site.add_paths %w[ /example/bar /example/baz ]
      #
      # Add lazy evaluator to create paths depending on business logic:
      # config.site.define_lazy_paths do
      #   YourCustomPageModel.all.map do |record|
      #     "/pages/#{record.id}"
      #   end
      # end

      # Define files in your 'public/' directory that are really static and should NOT be cleaned during site generation
      # (404.html 422.html 500.html and favicon.ico are included per default)
      # config.site.paths_to_except_from_cleanup << %[ robots.txt ]
    end

## Git Deployment

For some environments (like heroku) it is not possible to write keys out to the file system. One workaround is to store the ssh key in the environment.

The following script reads the content of your private key from `~/.ssh/id_rsa_rails_zero_deploy` and appends it to `.env`:

    echo "RAILS_ZERO_GIT_DEPLOYER_SSH_KEY_CONTENT=\"$(perl -p -e 's/\n/\\n/' ~/.ssh/id_rsa_rails_zero_deploy)\"" >> .env

For heroku I recommend using (heroku-config)[https://github.com/ddollar/heroku-config] keep your local `.env` file synchronized with heroku (via push / pull).

## Origin

This is work in progress. Build for and extracted from [Cocoa-Tree](http://cocoa-tree.github.io).

This project rocks and uses [MIT-LICENSE](MIT-LICENSE).
