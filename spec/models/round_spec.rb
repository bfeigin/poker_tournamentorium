require 'spec_helper'

describe "Round Model" do
  let(:round) { Round.new }
  it 'can be created' do
    round.should_not be_nil
  end

  it 'knows the betting phases for texas holdem' do 
    Round.betting_phases_for(:texas_holdem).should == [:pre_flop, :flop, :turn, :river]
  end
  
end
