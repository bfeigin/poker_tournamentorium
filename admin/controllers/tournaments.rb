Admin.controllers :tournaments do

  get :index do
    @tournaments = Tournament.all
    render 'tournaments/index'
  end

  get :new do
    @tournament = Tournament.new
    render 'tournaments/new'
  end

  post :create do
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      flash[:notice] = 'Tournament was successfully created.'
      redirect url(:tournaments, :edit, :id => @tournament.id)
    else
      render 'tournaments/new'
    end
  end

  get :show, :with => :id do
    @tournament = Tournament.find(params[:id])
    render 'tournaments/show'
  end

  get :edit, :with => :id do
    @tournament = Tournament.find(params[:id])
    render 'tournaments/edit'
  end

  put :update, :with => :id do
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = 'Tournament was successfully updated.'
      redirect url(:tournaments, :edit, :id => @tournament.id)
    else
      render 'tournaments/edit'
    end
  end

  delete :destroy, :with => :id do
    tournament = Tournament.find(params[:id])
    if tournament.destroy
      flash[:notice] = 'Tournament was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Tournament!'
    end
    redirect url(:tournaments, :index)
  end

  # Seat all available players at new games.
  post :seat do
    @tournament = Tournament.find(params[:id])
    @tournament.seat!
    flash[:notice] = 'Seating has begun.'
    redirect url(:tournaments, :show, :id => @tournament.id)
  end
end
