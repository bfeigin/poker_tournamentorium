require 'spec_helper'

describe "Round Model" do
  let(:round) { Round.new }
  it 'can be created' do
    round.should_not be_nil
  end

  it 'should be opened by default' do
    round.open.should be_true
  end

  it 'can be closed' do
    round.close!
    round.open.should be_false
  end

  context 'when playing' do
    let(:round) { Factory.create(:round)}
    let(:p1) {Factory.create(:player, :chips => 1000)}
    let(:p2) {Factory.create(:player, :chips => 1000)}
    let(:players) {[p1,p2]}


    before :each do
      @turn_sequence = sequence('hand')
      round.hand.stubs(:active_players).returns(players)
      $betting_sequence = []
      class Player
        def get_action
          $betting_sequence.delete_at(0).call
        end
      end
    end

    def bet(player,  amount)
      $betting_sequence <<  lambda{ Factory.create(:action, :action_name => "bet", :amount => amount, :round => round, :player => player)}
    end
    
    def fold(player, old_bet)
      $betting_sequence <<  lambda{ Factory.create(:action, :action_name => "fold", :round => round, :player => player)}
    end

    def blind(player, amount)
      $betting_sequence << lambda{ Factory.create(:action, :action_name => "blind", :amount => amount, :round => round, :player => player)}
    end

    it 'should blind correctly ' do
      blind(p1,50)
      blind(p2,100)
      bet(p1,100)
      bet(p2,200)
      bet(p1,200)
      round.play!
    end

    it 'should rotate around players until the bet equalizes' do
      round.betting_phase = 'flop'

      # Player 1 bets 50
      bet(p1, 50)

      # Player 2 raises
      bet(p2, 100)

      # Player 1 calls
      bet(p1, 100)

      # Round should end.

      round.play!

      players.should =~ [p1, p2]
    end

    it 'should remove a player from the hand once they fold' do

      # Player 1 folds
      fold(p1, 50)

      # Player 2 will win by default.

      round.play!

      players.should == [p2]
    end
  end
end
