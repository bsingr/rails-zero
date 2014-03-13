namespace :rails_zero do
  desc 'Generates the Site on the Remote'
  task :generate => :environment do
    RailsZero::GenerateSiteJob.new.run
  end

  namespace :deploy do
    desc 'Download'
    task :prepare => :environment do
      RailsZero::PackagesClient.new.get
    end

    desc 'Git deployment'
    task :git => :prepare do
      RailsZero::GitDeployer.new.run
    end
  end
end
