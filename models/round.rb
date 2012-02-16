class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

  def self.betting_phases_for(game_type = :texas_holdem)
      @game_rounds ||= {:texas_holdem => [:pre_flop, :flop, :turn, :river]}
      return @game_rounds[game_type]
  end

end
