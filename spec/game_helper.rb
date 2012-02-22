class Player
  def get_action
    $betting_sequence.delete_at(0)
  end
end
$betting_sequence = []


def bet(player,  amount)
  $betting_sequence <<  {:action => "bet", :amount => amount}
end

def fold(player)
  $betting_sequence <<  {:action => "fold"}
end

def blind(player, amount)
  $betting_sequence <<  {:action => "blind", :amount => amount}
end
