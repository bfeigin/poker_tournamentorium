Admin.controllers :tables do

  get :index do
    @tables = Game.all
    render 'tables/index'
  end

  get :new do
    @table = Game.new
    render 'tables/new'
  end

  post :create do
    @table = Game.new(params[:table])
    if @table.save
      flash[:notice] = 'Game was successfully created.'
      redirect url(:tables, :edit, :id => @table.id)
    else
      render 'tables/new'
    end
  end

  get :edit, :with => :id do
    @table = Game.find(params[:id])
    render 'tables/edit'
  end

  put :update, :with => :id do
    @table = Game.find(params[:id])
    if @table.update_attributes(params[:table])
      flash[:notice] = 'Game was successfully updated.'
      redirect url(:tables, :edit, :id => @table.id)
    else
      render 'tables/edit'
    end
  end

  delete :destroy, :with => :id do
    table = Game.find(params[:id])
    if table.destroy
      flash[:notice] = 'Game was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Game!'
    end
    redirect url(:tables, :index)
  end
end
