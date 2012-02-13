Admin.controllers :games do

  get :index do
    @games = Game.all
    render 'games/index'
  end

  get :new do
    @game = Game.new
    render 'games/new'
  end

  post :create do
    @game = Game.new(params[:game])
    if @game.save
      flash[:notice] = 'Game was successfully created.'
      redirect url(:games, :edit, :id => @game.id)
    else
      render 'games/new'
    end
  end

  get :edit, :with => :id do
    @game = Game.find(params[:id])
    render 'games/edit'
  end

  put :update, :with => :id do
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:notice] = 'Game was successfully updated.'
      redirect url(:games, :edit, :id => @game.id)
    else
      render 'games/edit'
    end
  end

  delete :destroy, :with => :id do
    game = Game.find(params[:id])
    if game.destroy
      flash[:notice] = 'Game was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Game!'
    end
    redirect url(:games, :index)
  end
end
