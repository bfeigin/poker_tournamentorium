class Player
  def get_action
    $betting_sequence.delete_at(0).call
  end
end
$betting_sequence = []


def bet(player,  amount)
  $betting_sequence <<  lambda{ Factory.create(:action, :action_name => "bet", :amount => amount, :round => round, :player => player)}
end

def fold(player)
  $betting_sequence <<  lambda{ Factory.create(:action, :action_name => "fold", :round => round, :player => player)}
end

def blind(player, amount)
  $betting_sequence << lambda{ Factory.create(:action, :action_name => "blind", :amount => amount, :round => round, :player => player)}
end
