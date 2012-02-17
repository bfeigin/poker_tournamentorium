require 'spec_helper'

describe "Round Model" do
  let(:round) { Round.new }
  it 'can be created' do
    round.should_not be_nil
  end

  it 'should be opened by default' do
    round.open.should be_true
  end

  it 'can be closed' do
    round.close!
    round.open.should be_false
  end

end
