# Module to include into the Player model.
module RemotePlayer
  TIMEOUT = 5

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
    RestClient::Request.execute(:method => :get, :url => ready_path, :payload => {}, :timeout => TIMEOUT, :open_timeout => TIMEOUT) do |response, request, result|
      response.code == 200
    end 
  rescue
    false
  end

  # Inform the player which table we're seating them at. A 200 should be guaranteed,
  # but if they've changed their mind, we just won't seat them at this table.
  def accepts_seat?(table)
    RestClient::Request.execute(:method => :post, :url => seating_path, :payload => { :game_table_identifier => "game_table_#{table.id}" }, :timeout => TIMEOUT, :open_timeout => TIMEOUT) do |response, request, result|
      response.code == 200
    end
  rescue
    false
  end

  # Get the next action for the player.
  def get_action(data)
    RestClient::Request.execute(:method => :post, :url => action_path, :payload => data, :timeout => TIMEOUT, :open_timeout => TIMEOUT) do |response, request, result|
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
    RestClient::Request.execute(:method => :post, :url => notify_path, :payload => data, :timeout => TIMEOUT, :open_timeout => TIMEOUT)
  rescue
    nil
  end
end
