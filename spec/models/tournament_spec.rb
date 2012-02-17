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

    tournament.expects(:players).returns([
                                            mock("player 1", :seat => true),
                                            mock("player 2", :seat => true),
                                            mock("player 3", :seat => true) 
                                         ])

    tournament.seat!
  end

  it "should create multiple tables if one fills up" do
    tournament = Factory.create :tournament

    9.times do 
      p = Factory.create :player, :tournament => tournament
    end
    Player.any_instance.expects(:accepts_seat?).at_least_once.returns(true)

    tournament.seat!

    tournament.game_tables.count.should == 2
  end
end
