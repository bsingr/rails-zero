require 'spec_helper'

module Relais
  describe PackagesController do
    routes { Relais::Engine.routes }
    
    let(:valid_session) { {} }

    describe "GET index" do
      it "returns package" do
        controller.should_receive(:send_file).with('public.tar')\
                  .and_return{controller.render :nothing => true}
        get :index, {}, valid_session
      end
    end
  end
end
