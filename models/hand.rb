class Hand < ActiveRecord::Base
  belongs_to :game_table
  has_many :rounds
end
