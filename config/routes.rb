RailsZero::Engine.routes.draw do
  get 'packages' => 'packages#index'
  get 'packages/new' => 'packages#new'
end
