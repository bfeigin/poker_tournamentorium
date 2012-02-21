class GameTable < ActiveRecord::Base
  MAX_PLAYERS = 8 # FIXME: Configure somewhere. AND do a full code-base search for MAX_PLAYERS (factory_girl duplication)
  has_many :hands 
  belongs_to :tournament
  has_many :seatings do
    def active
      where(:active => true)
    end
  end

  has_and_belongs_to_many :players, :join_table => :seatings, :conditions => {:seatings => {:active => true}}

  def begin_hand
    assign_dealer_position!
    return hands.find_or_create_by_active(true)
  end

  def small_blind
    1
  end

  def full?
    players.count >= MAX_PLAYERS
  end

  def assign_dealer_position!
    #Don't rotate if we don't have enough players to start playing
    return dealer_position unless seatings.active.size > 1
    # Look at the active seats, and find the next chronological seat to move the dealer to
    found_dealer_position = (seatings.active.map{|seat| seat.seat_number}.sort.select{|seat_number| seat_number > dealer_position}).first
    # If we looked through all  possible seats and havn't found a dealer, then start from the begining
    self[:dealer_position] = found_dealer_position || seatings.active.first.seat_number
    save
    self[:dealer_position]
  end
    
end
