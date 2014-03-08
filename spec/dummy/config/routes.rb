Rails.application.routes.draw do

  mount Relais::Engine => "/relais"

  get 'examples/cached' => 'examples#cached'
end
