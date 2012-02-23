Admin.controllers :game_tables do

  get :index do
    @game_tables = GameTable.all
    render 'game_tables/index'
  end

  get :new do
    @table = GameTable.new
    render 'game_tables/new'
  end

  post :create do
    @table = GameTable.new(params[:table])
    if @table.save
      flash[:notice] = 'GameTable was successfully created.'
      redirect url(:game_tables, :edit, :id => @table.id)
    else
      render 'game_tables/new'
    end
  end

  get :edit, :with => :id do
    @table = GameTable.find(params[:id])
    render 'game_tables/edit'
  end

  put :update, :with => :id do
    @table = GameTable.find(params[:id])
    if @table.update_attributes(params[:table])
      flash[:notice] = 'GameTable was successfully updated.'
      redirect url(:game_tables, :edit, :id => @table.id)
    else
      render 'game_tables/edit'
    end
  end

  delete :destroy, :with => :id do
    table = GameTable.find(params[:id])
    if table.destroy
      flash[:notice] = 'GameTable was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy GameTable!'
    end
    redirect url(:game_tables, :index)
  end
end
