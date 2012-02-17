class GameTable < ActiveRecord::Base
  MAX_PLAYERS = 8 # FIXME: Configure somewhere.
  has_many :hands 
  belongs_to :tournament
  has_and_belongs_to_many :players, :join_table => :seatings, :conditions => {:seatings => {:active => true}}

  def begin_hand
    return hands.find_or_create_by_active(true)
  end

  def full?
    players.count >= MAX_PLAYERS
  end
end
