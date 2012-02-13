require 'spec_helper'

describe "Player Model" do
  let(:player) { Player.new }
  it 'can be created' do
    player.should_not be_nil
  end
end
