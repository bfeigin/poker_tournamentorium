EnovaPoker.controllers :game_table do
  layout :app
  get :show, :with => :id do
    if @game_table = GameTable.find(params[:id])
      render "game_table/show"
    else
      status 404
      body "Not found."
    end
  end
end
