class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

  attr_accessor :max_bet 
  attr_accessor :current_bet
  attr_accessor :active_players

  def play!
    @active_players = hand.active_players
    @max_bet = @active_players.max_by{|player| player.chips_available}

    close! unless @active_players.size >= 2

    if betting_phase.to_sym == hand.betting_phases.first
      call_blinds(hand.game_table.small_blind)
    end

    @current_bet ||= 0

    while (action_to.current_bet != @current_bet) do
      action = action_to.get_action
      next_player!
      if action.is_fold? 
        @active_players.delete!(action_to)
      else
        @current_bet = action.amount
      end
    end
    close!
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
