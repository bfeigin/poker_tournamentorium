require 'spec_helper'

describe "Cards Model" do
  let(:cards) { Card.new }
  it 'can be created' do
    cards.should_not be_nil
  end
end
