require 'capybara/poltergeist'
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:timeout => 120,
                                          :js_errors => false})
end
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
