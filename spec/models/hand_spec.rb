require 'spec_helper'

describe "Hand Model" do
  let(:hand) { Hand.new }
  before  do
    Hand.any_instance.stubs(:game_table).returns(FactoryGirl.create(:game_table))
  end

  it 'can be created' do
    hand.should_not be_nil
  end

  it 'knows the betting phases for texas holdem' do 
    hand.betting_phases.should == [:pre_flop, :flop, :turn, :river]
  end

  it 'should never allow a nil betting phase' do
    hand.betting_phases.index(nil).should be_nil
  end
  

  context 'betting rounds' do
    before :each do 
      hand.save
    end
    it 'can open a new round' do
      hand.next_round
    end

    it 'should start with first betting phase' do
      hand.next_round
      hand.rounds.currently_open.betting_phase.should == hand.betting_phases.first.to_s
    end

    it 'should play by round for each betting phase' do
      hand.betting_phases.each do |phase|
        hand.next_round
        hand.rounds.currently_open.betting_phase.should == phase.to_s
        hand.rounds.where(:open => true).size.should == 1
        hand.rounds.currently_open.close!
      end
    end
  end
    
  context 'playing the game' do
    context 'full game no-actions' do
      before :each do 
        Player.any_instance.stubs(:chips_available).returns(200)
        Player.any_instance.stubs(:blind!).returns(FactoryGirl.create(:action))
        Player.any_instance.stubs(:current_bet).returns(200)
        Player.any_instance.stubs(:get_action).returns(FactoryGirl.create(:action))
        Hand.any_instance.stubs(:active_players).returns(FactoryGirl.create_list(:player,3))
      end
      it 'can be played' do
        hand.play!
        hand.rounds.size.should == 4
      end
    end
  end
end
