class GameTable < ActiveRecord::Base
  MAX_PLAYERS = 8 # FIXME: Configure somewhere. AND do a full code-base search for MAX_PLAYERS (factory_girl duplication)
  has_many :hands 
  belongs_to :tournament
  belongs_to :dealer, :class_name => "Player"
  has_many :seatings do
    def active
      where(:active => true)
    end
  end

  has_and_belongs_to_many :players, :join_table => :seatings, :conditions => {:seatings => {:active => true}}

  def play!
    while self.players.count > 1
      begin_hand.play!
    end
  end

  def begin_hand
    assign_dealer!
    hands.create # TODO: incorporate dealer position
  end

  def small_blind
    1
  end

  def full?
    players.count >= MAX_PLAYERS
  end

  def assign_dealer!
    if self.dealer.nil?
      # Start with the first.
      self.dealer = players.first
    else
      # Take the next player, or the first again.
      self.dealer = players.where(["players.id > ?", dealer.id]).first || players.first
    end
    save!
  end

  def unseat_player!(player)
    seating = seatings.reload.where(:player_id => player).first
    seating.active = false
    seating.save!
    players.reload
  end
end
