EnovaPoker.controllers :game_table do
  get "/show/:id" do
    if @game_table = GameTable.find(params[:id])
      render "game_table/show"
    else
      status 404
      body "Not found."
    end
  end
end
