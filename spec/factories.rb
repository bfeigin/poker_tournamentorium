require 'factory_girl'

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

  factory :game_table do
    tournament
    hands_played 0
  end

  factory :hand do
    game_table
    active true
  end

  factory :round do
    hand
  end

end
