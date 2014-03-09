require "spec_helper"

module Relais
  describe PackagesController do
    routes { Relais::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        get("/packages").should route_to("relais/packages#index")
      end

      it "routes to #new" do
        get("/packages/new").should route_to("relais/packages#new")
      end

    end
  end
end
