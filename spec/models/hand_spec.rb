require 'spec_helper'
require 'game_helper'

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

  context 'playing a game' do
    #let(:hand){Factory.create(:hand)}
    it 'plays a game' do
      pending
      hand = Factory.create(:hand)
      3.times {Seating.create(:game_table => hand.game_table, :player => Factory.create(:player))}
      puts hand.game_table.players.inspect
      puts "created hand #{hand.inspect}"
      puts "with players #{hand.players}"
      hand.game_table.players.size.should ==3
      puts hand.players.size
      p1,p2,p3 = hand.players
      # preflop
      
      blind(p1,50)
      blind(p2,100)
      fold(p3)
      bet(p1,100)
      bet(p2,100)

      #flop 

      bet(p1,200)
      bet(p2,200)

      #turn
      
      bet(p1,0)
      bet(p2,0)

      # river

      bet(p1,100)
      bet(p2,200)
      bet(p1,200)
      
      hand.play!
    end
  end
end
