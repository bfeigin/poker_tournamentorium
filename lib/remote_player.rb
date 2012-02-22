# Module to include into the Player model.
module RemotePlayer
  def seating_path
    "#{self.hostname}/player/seat"
  end

  def ready_path
    "#{self.hostname}/player/ready"
  end


  # Query if the player is ready to be seated or not.
  def ready?
   RestClient.get(ready_path, {}) do |response, request, result|
      response.code == 200
   end 
  end

  # Inform the player which table we're seating them at. A 200 should be guaranteed,
  # but if they've changed their mind, we just won't seat them at this table.
  def accepts_seat?(table)
    RestClient.post(seating_path, { :table => table.as_json }) do |response, request, result|
      response.code == 200
    end
  end

  def get_action(data)
    {:action => "fold"}
  end
 
end
