require 'spec_helper'

describe "Game Model" do
  let(:table) { Table.new }
  it 'can be created' do
    table.should_not be_nil
  end

  it 'should have a game type' do
    table.game_type.should_not be_nil
  end

  it 'can begin a new hand' do
    table.begin_new_hand!
  end
end
