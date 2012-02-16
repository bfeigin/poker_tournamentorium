class Tournament < ActiveRecord::Base
  has_many :players
  has_many :game_tables

  # Attempt to seat all available players.
  def seat!
    # Create a table. If it fills up, we'll add another one.
    current_table = tables.create()

    players.each do |p|
      if current_table.full?
        current_table = tables.create
      end

      p.seat(current_table)
    end
  end
end
