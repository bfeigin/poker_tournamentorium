require 'spec_helper'

describe "Player Model" do
  before :all do
    load 'models/player.rb'
  end

  let(:player) { Player.new }
  it 'can be created' do
    player.should_not be_nil
  end

  it 'should be able to sit at a table' do
    table = Factory.create(:game_table)
    player.stubs(:accepts_seat?).returns(true)

    player.seat(table)

    player.game_tables.current_table.should == table
  end

  describe 'cards' do
    it "should have cards" do
      player = Factory.create :player
      c = Factory.create(:card, :dealable_id => player.id)

      player.reload.cards.should include(c)
    end

    it "should get a card hash for a particular hand to send to the player" do
      p = Factory.create :player
      h = Factory.create(:hand)
      c1 = Factory.create(:card, :dealable_id => p.id, :hand => h, :value_code => "1")
      c2 = Factory.create(:card, :dealable_id => p.id, :value_code => "2")

      p.reload.cards.should =~ [c1, c2]
      p.cards_hash(h).should == [ c1.as_json ].to_param_hash
    end
  end

  describe "remote actions" do
    before :each do
      @player = Factory.create(:player)
      @table = Factory.create(:game_table)
      @player.hostname = "testhost"
    end

    it "should check if the player is ready via a GET to hostname/player/ready" do
      FakeWeb.register_uri(:get, "testhost/player/ready", 
            { :body => "", :status => ["200", "Okay"] })

      @player.ready?.should be_true
    end

    it "should seat the player if the client returns a 200 from a POST to hostname/player/seat" do
      FakeWeb.register_uri(:post, "testhost/player/seat",
            { :body => "", :status => ["200", "Okay"] })

      @player.seat(@table)

      @player.game_tables.current_table.should == @table
    end

    it "should not seat the player if the client returns a 403" do
      FakeWeb.register_uri(:post, "testhost/player/seat",
            { :body => "", :status => ["403", "Not Gonna Bother"] })

      @player.seat(@table)

      @player.game_tables.current_table.should be_nil
    end

    it "should post to hostname/player/action to determine the player's action" do
      FakeWeb.register_uri(:post, "testhost/player/action",
            { :body => "{\"action\": \"bet\", \"amount\": 100}", :status => ["200", "Okay"] })

      @player.get_action({}).should == {:action => "bet", :amount => 100}
    end
  end
end
