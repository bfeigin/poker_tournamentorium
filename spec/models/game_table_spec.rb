require 'spec_helper'

describe "GameTable Model" do
  let(:game_table) { FactoryGirl.create(:game_table)}

  it 'can be created' do
    game_table.should_not be_nil
  end

  it 'should have a game type' do
    game_table.game_type.should_not be_nil
  end

  describe 'playing a hand' do
    it 'can begin a new hand' do
      game_table.begin_hand
    end
  end
end
