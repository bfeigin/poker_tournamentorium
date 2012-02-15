require 'spec_helper'

describe "FactoryGirl" do
  it "should create a tournament" do
    t = Factory.create(:tournament)
    t.should_not be_nil
    t.name.should_not be_empty
  end

  it "should create a player" do
    p = Factory.create(:player)
    p.should_not be_nil
    p.name.should_not be_empty
    p.tournament.should be_a(Tournament)
  end

end
