# Local player that accepts console input for bets.
module InteractivePlayer
  def ready?
    true
  end

  def accepts_seat?(table)
    true
  end

  def get_action
    puts "Action to you, #{name}. fold/bet <amount>?"

    input = gets
    
    if input == "fold"
      {:action => "fold"}
    else
      parts = input.split(" ")
      if parts.first == "bet"
        {:action => "bet", :amount => parts.last.to_i}
      end
    end
  end

end
