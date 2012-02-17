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
end
