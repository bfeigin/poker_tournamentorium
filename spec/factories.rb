require 'factory_girl'

MAX_PLAYERS = 8
FactoryGirl.define do
  factory :tournament do
    name "The Poker Tournament"
  end

  factory :player do
    sequence :name do |n|
      "Player ##{n}"
    end
    
    tournament
  end

  factory :seating do
    player
    game_table
    sequence :seat_number do |n|
      n % MAX_PLAYERS
    end
  end

  factory :action do
    player
    round
    action_name 'bet'
    amount 200
  end

  factory :game_table do
    tournament
    hands_played 0
  end

  factory :hand do
    game_table
    active true
  end

  factory :card do
    hand
    suit_code "H"
    value_code "T"
    dealable_id Factory.create(:player).id
    dealable_type "Player"
  end

  factory :round do
    betting_phase 'flop'
    hand
  end
end
