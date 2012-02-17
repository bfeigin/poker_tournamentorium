# Module to include into the Player model.
module RemotePlayer
  def seating_path
    "#{self.hostname}/seating"
  end

  def accepts_seat?(table)
    RestClient.post(seating_path, :params => { :table => table.as_json }) do |response, request, result|
      response.code == 200
    end
  end

  def get_action(round)
    puts "trying to get action!"
  end
end
