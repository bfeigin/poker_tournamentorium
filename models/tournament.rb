class Tournament < ActiveRecord::Base
  has_many :players
  has_many :game_tables

  # Attempt to seat all available players.
  def seat!

  end
end
