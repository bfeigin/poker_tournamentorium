EnovaPoker.controllers :tournament do
  layout :app
  # Player wants to register for a tournament
  # Posts: name:string, hostname:uri
  # Response: 200 - player is registered
  # Response: 404 - No tournaments active
  post :register do
    tournament = Tournament.find(:last)
    if tournament && Player.new(:name => params[:name], :hostname => params[:hostname], :tournament => tournament).save
      status 200
      body "Welcome to the party!"
    else
      status 404
      body "No active tournaments."
    end
  end


  get :show do
    @tournament = Tournament.find(:last)
    if @tournament
      @game_tables = @tournament.game_tables.order("id desc")

      render "tournament/show"
    else
      status 404
      body "No active tournaments."
    end
  end
end
