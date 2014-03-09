require "spec_helper"

module RailsZero
  describe PackagesController do
    routes { RailsZero::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        get("/packages").should route_to("rails_zero/packages#index")
      end

      it "routes to #new" do
        get("/packages/new").should route_to("rails_zero/packages#new")
      end

    end
  end
end
