Admin.controllers :game_tables do

  post :create do
    @tournament = Tournament.find(params[:tournament_id])
    game_table = GameTable.new(:tournament => @tournament)
    if game_table.save
      flash[:notice] = "Table for the tournament #{@tournament.name} created!"
    else
      flash[:notice] = "Unable to create a table, pleae try again"
    end
    redirect url(:tournaments, :show, :id => @tournament.id)
  end

end
