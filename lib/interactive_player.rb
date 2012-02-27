# Local player that accepts console input for bets.
module InteractivePlayer
  def ready?
    true
  end

  def accepts_seat?(table)
    true
  end

  def get_action(data)
    puts "Action to you, #{name}. #{data.inspect}"
    puts "fold/blind <amount>/bet <amount>?"

    input = gets
    
    if input == "fold"
      {:action => "fold"}
    else
      parts = input.split(" ")
      if parts.first == "bet"
        {:action => "bet", :amount => parts.last.to_i}
      elsif parts.first == "blind"
        {:action => "blind", :amount => parts.last.to_i}
      end
    end
  end

  def notify(data)
  end
end
