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

    tournament.expects(:players).returns(mock('proxy', :where => [
                                            mock("player 1", :seat => true, :ready? => true, :id => 1),
                                            mock("player 2", :seat => true, :ready? => true, :id => 2),
                                            mock("player 3", :seat => true, :ready? => true, :id => 3) 
                                         ]))

    tournament.game_tables.create
    tournament.seat!
  end

  it "should check if a player is ready to seat first" do
    tournament = Factory.create :tournament
    p = Factory.create :player, :tournament => tournament
    tournament.expects(:players).returns(mock('proxy', :where => [p]))
    p.expects(:ready?)

    tournament.seat!
  end

  it "should fill tables evenly" do
    tournament = Factory.create :tournament

    9.times do 
      p = Factory.create :player, :tournament => tournament, :chips => 10
    end
    Player.any_instance.expects(:ready?).at_least_once.returns(true)
    Player.any_instance.expects(:accepts_seat?).at_least_once.returns(true)

    tournament.game_tables.create
    tournament.game_tables.create
    tournament.seat!

    tournament.game_tables.count.should == 2
    tournament.game_tables.first.reload.players.count.should < 6
    tournament.game_tables.last.reload.players.count.should < 6
  end
end
