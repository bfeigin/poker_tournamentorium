require 'spec_helper'

describe "GameTable Model" do
  let(:game_table) { FactoryGirl.create(:game_table)}

  it 'can be created' do
    game_table.should_not be_nil
  end

  it 'should have a game type' do
    game_table.game_type.should_not be_nil
  end

  it 'should start off not full' do
    game_table.full?.should be_false
  end

  describe 'dealer position' do 
    it 'defaults to seating 1' do
      game_table.dealer_position.should == 0
    end

    context 'not enough active players' do
      it 'keeps the current dealer position ' do
        game_table.assign_dealer_position!
        game_table.dealer_position.should == 0
      end
    end

    context 'there are enough active players!' do 
      before :all do
        (1..3).each do 
          FactoryGirl.create(:seating, :game_table => game_table, :active => true)
        end
      end
      it 'assigns dealer to the next available seat' do
        (1..3).each do |x|
          game_table.assign_dealer_position!
          game_table.dealer_position.should == x
        end
      end

      it 'wraps around the table' do
        4.times do |x|
          game_table.assign_dealer_position!
        end
        game_table.dealer_position.should == 1
      end
    end
  end

  describe 'playing a hand' do
    it 'can begin a new hand' do
      game_table.begin_hand
    end
  end
end
