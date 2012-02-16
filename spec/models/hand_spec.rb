require 'spec_helper'

describe "Hand Model" do
  let(:hand) { Hand.new }
  it 'can be created' do
    hand.should_not be_nil
  end

end
