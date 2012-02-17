class Hand < ActiveRecord::Base
  belongs_to :game_table
  has_many :players, :through  => :game_tables

  has_many :rounds do
    def currently_open
      where(:open => true).first
    end
  end

  def next_round!
    save
    if next_betting_phase
      if rounds.currently_open
        rounds.currently_open.close!
      end
      rounds.create(:betting_phase => next_betting_phase)
    else
      close_hand!
    end
    rounds.currently_open
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

end
