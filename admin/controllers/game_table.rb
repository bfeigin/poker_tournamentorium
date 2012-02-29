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

  post :close do
    @game_table = GameTable.find(params[:id])
    if @game_table.close
      flash[:notice] = "Table is now #{@game_table.status}"
    else
      flash[:notice] = "Failed to change the status of the table"
    end
    redirect url(:tournaments, :show, :id => @game_table.tournament.id)
  end

end
