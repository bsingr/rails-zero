require_dependency "relais/application_controller"

module Relais
  class PackagesController < ApplicationController
    def index
      send_file 'public.tar'
    end
  end
end
