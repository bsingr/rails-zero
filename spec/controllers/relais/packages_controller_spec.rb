require 'spec_helper'

module Relais
  describe PackagesController do
    routes { Relais::Engine.routes }
    
    let(:valid_session) { {} }

    describe "GET index" do
      it "returns package" do
        controller.should_receive(:send_file)\
                  .with(Rails.root.join('tmp', 'packages', 'public.tar'))\
                  .and_return{controller.render :nothing => true}
        get :index, {}, valid_session
      end
    end

    describe "GET new" do
      it 'runs clean site job' do
        expect_any_instance_of(CleanSiteJob).to receive(:run).once
        get :new, {}, valid_session
      end
    end
  end
end
