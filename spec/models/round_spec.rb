require 'spec_helper'

describe "Round Model" do
  let(:round) { Round.new }
  it 'can be created' do
    round.should_not be_nil
  end

  it 'knows the betting rounds for texas holdem' do 
    round.rounds_for(:texas_holdem).should == [:pre_flop, :flop, :turn, :river]
  end
  
end
