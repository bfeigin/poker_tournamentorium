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
    before :each do
      @turn_sequence = sequence('hand')
    end

    def bet(player, old_bet, amount)
      player.expects(:current_bet).in_sequence(@turn_sequence).returns(old_bet)
      player.expects(:get_action).in_sequence(@turn_sequence).returns(Factory.create(:action, :action => "bet", :amount => amount))
    end
    
    def fold(player, old_bet)
      player.expects(:current_bet).in_sequence(@turn_sequence).returns(old_bet)
      player.expects(:get_action).in_sequence(@turn_sequence).returns(Factory.create(:action, :action => "fold"))
    end

    it 'should rotate around players until the bet equalizes' do
      round = Factory.create(:round)

      p1 = stub('Player 1', :chips_available => 1000)
      p2 = stub('Player 2', :chips_available => 1000)
      players = [p1, p2]
      round.hand.stubs(:active_players).returns(players)

      # Player 1 raises
      bet(p1, 25, 50)

      # Player 2 raises
      bet(p2, 25, 100)

      # Player 1 calls
      bet(p1, 50, 100)
      
      p2.expects(:current_bet).in_sequence(@turn_sequence).returns(100)

      # Round should end.

      round.play!

      players.should =~ [p1, p2]
    end

    it 'should remove a player from the hand once they fold' do
      round = Factory.create(:round)

      p1 = stub('Player 1', :chips_available => 1000)
      p2 = stub('Player 2', :chips_available => 1000)
      players = [p1, p2]
      round.hand.stubs(:active_players).returns(players)

      # Player 1 folds
      fold(p1, 50)

      # Player 2 will win by default.

      round.play!

      players.should == [p2]
    end
  end

end
