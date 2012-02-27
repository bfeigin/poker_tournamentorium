# Module to include into the Player model.
module RemotePlayer
  def seating_path
    "#{self.hostname}/player/seat"
  end

  def ready_path
    "#{self.hostname}/player/ready"
  end

  def action_path
    "#{self.hostname}/player/action"
  end

  def notify_path
    "#{self.hostname}/player/notify"
  end


  # Query if the player is ready to be seated or not.
  def ready?
    RestClient.get(ready_path, {}) do |response, request, result|
      response.code == 200
    end 
  rescue
    false
  end

  # Inform the player which table we're seating them at. A 200 should be guaranteed,
  # but if they've changed their mind, we just won't seat them at this table.
  def accepts_seat?(table)
    RestClient.post(seating_path, { :table => table.as_json }) do |response, request, result|
      response.code == 200
    end
  rescue
    false
  end

  # Get the next action for the player.
  def get_action(data)
    RestClient.post(action_path, data) do |response, request, result|
      if response.code == 200
        begin
          JSON.parse(response).symbolize_keys
        rescue => e
          logger.info "Exception #{e} raised in parsing response."
          {:action => "fold"}
        end
      else
        {:action => "fold"}
      end
    end
  rescue
    {:action => "fold"}
  end

  # Notify the player of some event.
  def notify(data={})
    RestClient.post(notify_path, data)
  rescue
    nil
  end
end
