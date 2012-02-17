class Tournament < ActiveRecord::Base
  has_many :players
  has_many :game_tables

  # Attempt to seat all available players.
  def seat!
    # Create a table. If it fills up, we'll add another one.
    current_table = game_tables.create()

    # Get a list of ready players (make GET requests to each).
    ready_players = players.select do |p|
      p.ready?
    end

    # Attempt to seat all ready players.
    ready_players.each do |p|
      if current_table.full?
        current_table = game_tables.create
      end

      p.seat(current_table)
    end
  end
end
