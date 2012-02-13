Admin.controllers :players do

  get :index do
    @players = Player.all
    render 'players/index'
  end

  get :new do
    @player = Player.new
    render 'players/new'
  end

  post :create do
    @player = Player.new(params[:player])
    if @player.save
      flash[:notice] = 'Player was successfully created.'
      redirect url(:players, :edit, :id => @player.id)
    else
      render 'players/new'
    end
  end

  get :edit, :with => :id do
    @player = Player.find(params[:id])
    render 'players/edit'
  end

  put :update, :with => :id do
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:notice] = 'Player was successfully updated.'
      redirect url(:players, :edit, :id => @player.id)
    else
      render 'players/edit'
    end
  end

  delete :destroy, :with => :id do
    player = Player.find(params[:id])
    if player.destroy
      flash[:notice] = 'Player was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Player!'
    end
    redirect url(:players, :index)
  end
end
