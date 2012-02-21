class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

  attr_accessor :max_bet 
  attr_accessor :current_bet
  attr_accessor :active_players

  def non_blinds_for_player(player)
     actions.where("action_name NOT in ('blind')").where(:player_id => player)
  end

  def play!
    @active_players = hand.active_players
    @max_bet = @active_players.max_by{|player| player.chips}

    close! unless enough_players?

    if betting_phase.to_sym == hand.betting_phases.first
      call_blinds(hand.game_table.small_blind)
    end

    @current_bet ||= 0

    puts
    while ( enough_players? && 
            (player = action_to) && 
            ((non_blinds_for_player(player).size == 0) ||
            (bet = player.current_bet) != @current_bet)) do 
      puts "non_blinds: #{non_blinds_for_player(player).all}"
      puts "actions: #{actions.where(:player_id => player).all}"
      #puts "Active players: #{@active_players.inspect}"
      puts "Min bet: $#{@current_bet}"
      puts "Action to #{player.inspect} with current bet #{bet}"
      puts 

      action = player.get_action
      next_player! # Rotate first, to ensure progress.

      if action.is_fold?         
        puts "Fold."
        @active_players.delete(player)
      else
        puts "Bet of #{action.amount}."
        accept_bet(action)
      end
    end
    close!
  end

  def accept_bet(action)
    @current_bet = action.amount
    true
  end
  def actions_taken
    actions
  end

  def enough_players?
    @active_players.size > 1
  end

  def next_player!
    @active_players.rotate!
  end

  def call_blinds(small_blind)
    (1..2).each do |blind|
      action_to.blind!(small_blind * blind)
      next_player!
    end
    @current_bet = small_blind * 2
  end

  def action_to
    @active_players.first
  end

  def close!
    self[:open] = false
    save
  end
end
