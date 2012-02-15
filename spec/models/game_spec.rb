require 'spec_helper'

describe "Game Model" do
  let(:game) { Game.new }
  it 'can be created' do
    game.should_not be_nil
  end

  it 'should start in the pre_flop betting round' do
    game.betting_round.should == 'pre-flop'
  end
end
