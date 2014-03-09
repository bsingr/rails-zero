require 'spec_helper'

describe RailsZero::PagesConfig do
  its('links') { should == [] }
  its('paths_to_except_from_cleanup') { should == [
    Rails.root.join('public/404.html').to_s,
    Rails.root.join('public/422.html').to_s,
    Rails.root.join('public/500.html').to_s,
    Rails.root.join('public/favicon.ico').to_s
  ] }
end
