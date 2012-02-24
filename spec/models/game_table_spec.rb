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

  it 'can unseat players' do
    3.times do FactoryGirl.create(:seating, :game_table => game_table, :active => true) end
    puts game_table.inspect
    game_table.reload.unseat_player!(game_table.players.first)

    game_table.players.count.should == 2
  end

  describe 'dealer position' do 
    let(:game_table) { FactoryGirl.create(:game_table)}

    context 'one active player' do
      before :all do
        FactoryGirl.create(:seating, :game_table => game_table, :active => true).player
        game_table.reload
      end

      it 'defaults to seating the first player' do
        game_table.assign_dealer!
        game_table.dealer.should == game_table.players.first
      end

      it 'keeps the current dealer position ' do
        game_table.assign_dealer!
        game_table.assign_dealer!
        game_table.dealer.should == game_table.players.first
      end
    end

    context 'there are enough active players!' do 
      before :all do
        (1..3).each do 
          FactoryGirl.create(:seating, :game_table => game_table, :active => true)
        end
      end

      it 'assigns dealer to the next available seat' do
        (0..2).each do |x|
          game_table.assign_dealer!
          game_table.dealer.should == game_table.players[x]
        end
      end

      it 'wraps around the table' do
        4.times do |x|
          game_table.assign_dealer!
        end
        game_table.dealer.should == game_table.players.first
      end
    end
  end

  describe 'playing a hand' do
    it 'can begin a new hand' do
      game_table.begin_hand
    end
  end

  describe 'playing a game' do
    it 'plays hands until one player remains' do
      seq = sequence('hands')
      players = mock('association')
      game_table.stubs(:players).returns(players)
      players.expects(:count).in_sequence(seq).returns(3)
      game_table.expects(:begin_hand).in_sequence(seq).returns(nil)
      players.expects(:count).in_sequence(seq).returns(3)
      game_table.expects(:begin_hand).in_sequence(seq).returns(nil)
      players.expects(:count).in_sequence(seq).returns(2)
      game_table.expects(:begin_hand).in_sequence(seq).returns(nil)
      players.expects(:count).in_sequence(seq).returns(1)

      game_table.play!
    end
  end
end
