# Scripted player to be used for testing purposes.
module ScriptedPlayer
  def ready?
    true
  end

  def accepts_seat?(table)
    true
  end

  def get_action
    action = @action_queue.pop 

    puts action.inspect

    action
  end

  def queue_action(action)
    (@action_queue ||= []).push(action)
  end

  def queue_bet(amount)
    queue_action({:action => "bet", :amount => amount})
  end

  def queue_fold(amount)
    queue_action({:action => "fold"})
  end
end
