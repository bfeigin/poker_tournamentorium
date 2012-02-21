class Hand < ActiveRecord::Base
  belongs_to :game_table

  has_many :rounds do
    def currently_open
      where(:open => true).first
    end
  end
  
  def deck
    @deck ||= Deck.new
  end


  def play!
    save 
    deal_pocket_cards!
    while next_round do
      rounds.currently_open.play!
    end
    close_hand!
  end

  def deal_pocket_cards!
    2.times do 
      active_players.each do |player|
        Card.create(deck.card!.merge(:player => player, :hand => self))
      end
    end
  end

  def next_round
    if next_betting_phase
      rounds.create(:betting_phase => next_betting_phase, :open => true, :hand => self)
    else
      false
    end
  end

  def close_hand!
  end

  #If we have a currently open round, then get the betting phase after that
  def next_betting_phase
    if rounds.last
      return betting_phases[betting_phases.index(rounds.last.betting_phase.to_sym)  + 1]
    else
      betting_phases.first
    end
  end

  def current_betting_phase
    (rounds.currently_open && rounds.currently_open.betting_phase) || -1
  end

  # Can never have nil
  def betting_phases
    @betting_phases ||= [:pre_flop, :flop, :turn, :river]
  end

  def players
    game_table.players
  end

  def active_players
    players.all
  end

end
