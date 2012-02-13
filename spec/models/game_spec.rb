require 'spec_helper'

describe "Game Model" do
  let(:game) { Game.new }
  it 'can be created' do
    game.should_not be_nil
  end
end
