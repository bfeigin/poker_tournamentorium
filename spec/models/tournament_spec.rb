require 'spec_helper'

describe "Tournament Model" do
  let(:tournament) { Tournament.new }
  it 'can be created' do
    tournament.should_not be_nil
  end
end
