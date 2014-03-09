namespace :rails_zero do
  desc 'Generates the Site on the Remote'
  task :generate => :environment do
    RailsZero::GenerateSiteJob.new.run
  end
end
