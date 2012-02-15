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

end
