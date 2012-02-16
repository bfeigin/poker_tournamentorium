class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

  def rounds_for(table_type = :texas_holdem)
      @rounds ||= {:texas_holdem => [:pre_flop, :flop, :turn, :river]}
      return @rounds[table_type]
  end

end
