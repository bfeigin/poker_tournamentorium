require 'spec_helper'
require 'game_helper'

describe "Round Model" do
  let(:round) { Factory.create :round }
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
      round.hand.stubs(:players).returns(players.dup)
    end

    it 'should blind correctly ' do
      round.betting_phase = 'pre_flop'
      start_round()
      blind(p1,1)
      blind(p2,2)
      bet(p1,100)
      bet(p2,200)
      bet(p1,200)
      round.play!
      round.actions.where(:action_name => 'blind').size.should == 2
    end

    it 'should rotate around players until the bet equalizes' do
      round.betting_phase = 'flop'

      start_round()

      # Player 1 bets 50
      bet(p1, 50)

      # Player 2 raises
      bet(p2, 100)

      # Player 1 calls
      bet(p1, 100)

      # Round should end.

      round.play!

      players.should =~ [p1, p2]
      p1.reload.chips.should == 900
    end

    it 'should remove a player from the hand once they fold' do
      round.betting_phase = 'flop'

      start_round()
      # Player 1 folds
      fold(p1)

      # Player 2 will win by default.

      round.play!

      players.should == [p2]
    end
  end

  context 'when validating bets' do
    before :each do
      @r = Round.new
      @r.stubs(:current_bet).returns(50)
      @r.stubs(:max_bet).returns(100)

      @p = stub('player', :chips => 100)
      @p.stubs(:reload).returns(@p)
    end

    it "should validate a valid bet" do
      @r.validate_action({:action => "bet", :amount => 75}, @p).should be_true
    end

    it "should validate a fold" do
      @r.validate_action({:action => "fold"}, @p).should be_true
    end

    it "should reject an invalid bet" do
      @r.validate_action({:action => "bet", :amount => 5}, @p).should be_false
    end

    it "should reject a garbled action" do
      @r.validate_action({:action => "basdfet", :aasdfmount => 5}, @p).should be_false
    end
  end

  it "should fold players from itself" do
    @r = Round.new
    p = stub('player')
    p.expects(:notify).returns nil
    @r.active_players = [p]

    @r.fold_player!(p)
    @r.active_players.should == []
  end

  it "should fold players and unseat from the game table when unseating them" do
    @r = Round.new
    p = stub('player', :id => nil)
    Action.expects(:create).returns nil
    p.expects(:notify).at_least_once.returns nil
    @r.active_players = [p]
    
    @r.expects(:hand).returns(mock('hand', :game_table => (mock('game', :unseat_player! => nil))))
    @r.expects(:fold_player!).with(p).returns(nil)

    @r.unseat_player!(p)
  end
end
