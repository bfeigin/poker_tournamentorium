require 'spec_helper'

describe "Tournament Model" do
  let(:tournament) { Tournament.new }
  it 'can be created' do
    tournament.should_not be_nil
  end

  it "should have players" do
    tournament = Factory.create :tournament

    3.times do
      Factory.create(:player, :tournament => tournament)
    end

    tournament.players.count.should == 3
  end

  it "should attempt to seat all available players" do
    tournament = Factory.create :tournament

    3.times do
      player = Factory.create(:player, :tournament => tournament)
      player.expects(:seat).once
    end

    tournament.seat!
  end
end
