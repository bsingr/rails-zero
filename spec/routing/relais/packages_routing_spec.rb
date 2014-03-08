require "spec_helper"

module Relais
  describe PackagesController do
    routes { Relais::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        get("/packages").should route_to("relais/packages#index")
      end

    end
  end
end
