require 'spec_helper'

describe "Seating Model" do
  let(:seating) { Seating.new }
  it 'can be created' do
    seating.should_not be_nil
  end
end
