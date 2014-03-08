require 'spec_helper'

module Relais
  describe PackagesClient do
    it "downloads package" do
      Kernel.should_receive('system').with("curl /relais/packages > public.tar")
      subject.get
    end
  end
end
