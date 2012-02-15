require 'spec_helper'

describe "Round Model" do
  let(:round) { Round.new }
  it 'can be created' do
    round.should_not be_nil
  end
end
