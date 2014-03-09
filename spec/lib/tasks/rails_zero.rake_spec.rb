require 'spec_helper'

describe "rails_zero:generate" do
  include_context "rake"

  its(:prerequisites) { should include("environment") }

  it "generates the site" do
    expect_any_instance_of(RailsZero::GenerateSiteJob).to receive(:run).with()
    subject.invoke
  end
end
