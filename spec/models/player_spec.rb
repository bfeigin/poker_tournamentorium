require 'spec_helper'

describe "Player Model" do
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

  describe "remote actions" do
    before :each do
      @player = Factory.create(:player)
      @table = Factory.create(:game_table)
      @player.hostname = "testhost"
      
    end

    it "should seat the player if the client returns a 200 from a POST to hostname/seating" do
      FakeWeb.register_uri(:post, "testhost/seating",
            { :body => "", :status => ["200", "Okay"] })

      @player.seat(@table)

      @player.game_tables.current_table.should == @table
    end

    it "should not seat the player if the client returns a 403" do
      FakeWeb.register_uri(:post, "testhost/seating",
            { :body => "", :status => ["403", "Not Gonna Bother"] })

      @player.seat(@table)

      @player.game_tables.current_table.should be_nil
    end
  end
end
