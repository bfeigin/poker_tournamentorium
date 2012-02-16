class Tournament < ActiveRecord::Base
  has_many :players
  has_many :games

  # Attempt to seat all available players.
  def seat!

  end
end
