class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

  attr_accessor :max_bet 
  attr_accessor :current_bet
  attr_accessor :active_players

  def current_bet
    @current_bet ||= 0
  end

  def non_blinds_for_player(player)
     actions.where("action_name NOT in ('blind')").where(:player_id => player)
  end

  def play!
    puts "entering round #{inspect}"
    @active_players = hand.active_players
    puts "with players #{@active_players}"
    @max_bet = @active_players.max_by{|player| player.chips}

    close! unless enough_players?

    if betting_phase.to_sym == hand.betting_phases.first
      call_blinds(hand.game_table.small_blind)
    end

    puts
    while ( enough_players? && 
            (player = action_to) && 
            ((non_blinds_for_player(player).size == 0) ||
            (bet = player.current_bet) != @current_bet)) do 
      puts "Min bet: $#{@current_bet}"
      puts "Action to #{player.inspect} with current bet #{bet}. Hand: #{player.cards.collect { |c| c.value_code.to_s + c.suit_code.to_s}}"
      puts 

      action_hash = player.get_action(turn_data)
      next_player! # Rotate first, to ensure progress.

      if validate_action(action_hash, player)
        action = Action.create(:player => player, :round => self, :action_name => action_hash[:action].to_s, :amount => action_hash[:amount].to_i)
      else
        action = Action.create(:player => player, :round => self, :action_name => "fold")
      end

      if action.is_fold?         
        puts "Fold."
        fold_player!(player)
      else
        puts "Bet of #{action.amount}."
        accept_bet(action)
      end
    end
    close!
  end

  def validate_action(action_hash, player, args={})
    logger.info "Trying to validate #{action_hash.inspect}"
    return false unless action_hash.is_a? Hash

    # Handle the blinds case first.
    # The action MUST be blind, and the amount MUST be the current bet.
    if args[:blind] then
      return action_hash[:action] == "blind" &&
             (amount = action_hash[:amount]) &&
             amount.to_i == current_bet && 
             player.reload.chips >= amount.to_i            
    else
      # Either a bet or fold is allowed.
      if action_name = action_hash[:action]
        if action_name.to_s == "bet"
          if amount = action_hash[:amount]
            # A bet is only valid if it meets the minimum bet.
            amount.to_i >= (current_bet || 0) && player.reload.chips >= amount.to_i
          end
        elsif action_name.to_s == "fold"
          true
        else
          false
        end
      else
        # Missing a required parameter.
        false
      end
    end
  end

  def fold_player!(player)
    @active_players.delete(player)
    player.notify(:event => "folded")
  end

  def unseat_player!(player)
    fold_player!(player)
    hand.game_table.unseat_player!(player)
    player.notify(:event => "unseated")
  end

  def accept_bet(action)
    @current_bet = action.amount

    # Move money into the pot from the player's chips.
    self.pot += action.amount
    action.player.chips -= action.amount
    action.player.save!
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

  # Generate a hash of turn data to send the player.
  def turn_data(args={})
    action_to.reload

    {
      :minimum_bet      => current_bet,
      :blind            => !!args[:blind],
      :your_chips       => action_to.chips,
      :your_hand        => action_to.cards_hash(self.hand),
      :community_cards  => hand.community_cards.as_json.to_param_hash
    }
  end

  def call_blinds(small_blind)
    (1..2).each do |blind|
      return unless enough_players?

      blind_amount = small_blind * blind
      @current_bet = blind_amount

      action_hash = action_to.get_action(turn_data(:blind => true))
      
      if validate_action(action_hash, action_to, {:blind => true})
        action = Action.create(:player => action_to, :round => self, :action_name => action_hash[:action].to_s, :amount => action_hash[:amount].to_i)
        accept_bet(action)
      else
        unseat_player!(action_to)
      end

      next_player!
    end
  end

  def action_to
    @active_players.first
  end

  def close!
    self[:open] = false
    save
  end
end
