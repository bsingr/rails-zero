namespace :rails_zero do
  desc 'Generates the Site on the Remote'
  task :generate => :environment do
    RailsZero::GenerateSiteJob.new.run
  end

  namespace :deploy do
    desc 'Git deployment'
    task :git do
      RailsZero::GitDeployer.new.run
    end
  end
end
