module Relais
  class Engine < ::Rails::Engine
    isolate_namespace Relais
    
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      #g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer 'relais.set_page_cache_dir' do |app|
      app.config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/deploy"
    end
  end
end
