require 'spec_helper'

describe "Action Model" do
  let(:action) { Action.new }
  it 'can be created' do
    action.should_not be_nil
  end
end
