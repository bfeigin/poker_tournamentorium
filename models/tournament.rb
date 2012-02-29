class Tournament < ActiveRecord::Base
  has_many :players
  has_many :game_tables

  # Attempt to seat all available players.
  def seat!
    # Create a table. If it fills up, we'll add another one.
    #current_table = game_tables.create()

    # Get a list of ready players (make GET requests to each).
    ready_players = players.select do |p|
      p.ready?
    end

    # Attempt to seat all ready players.
    #ready_players.each do |p|
    #  if current_table.full?
    #    current_table = game_tables.create
    #  end

    #  p.seat(current_table)

    #number_of_players_per_table = (ready_players.size.to_f / game_tables.size).ceil
    estimated_players = ready_players.group_by { |p| p.id % game_tables.size }

    puts estimated_players.inspect

    game_tables.each_with_index do |gt, i|
      estimated_players[i].each do |p|
        p.seat(gt)
      end
      gt.save
    end
  end
  
  def open?
    registration == 'open'
  end

  def close!
    self.registration = 'close'
    save
  end
end
