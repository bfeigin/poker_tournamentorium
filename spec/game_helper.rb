def start_round
  $betting_sequence = sequence('round')
end

def bet(player,  amount)
  player.expects(:get_action).in_sequence($betting_sequence).returns({:action => "bet", :amount => amount})
end

def fold(player)
  player.expects(:get_action).in_sequence($betting_sequence).returns({:action => "fold"})
end

def blind(player, amount)
  player.expects(:get_action).in_sequence($betting_sequence).returns({:action => "blind", :amount => amount})
end
