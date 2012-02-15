require 'spec_helper'

describe "TournamentController" do
  it "should return a 404 if no tournament exists" do
    post 'tournament/register', { :hostname => "localhost:1234", :name => "Bob" }

    last_response.status.should == 404
  end

  it "should allow players to register for the current tournament" do
    tournament = Factory.create(:tournament)

    post 'tournament/register', { :hostname => "localhost:1234", :name => "Bob" }

    last_response.ok?.should be_true
  end

end
