Rails.application.routes.draw do

  mount RailsZero::Engine => "/rails_zero"

  get 'examples/cached' => 'examples#cached'
end
