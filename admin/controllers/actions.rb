Admin.controllers :actions do

  get :index do
    @actions = Action.all
    render 'actions/index'
  end

  get :new do
    @action = Action.new
    render 'actions/new'
  end

  post :create do
    @action = Action.new(params[:action])
    if @action.save
      flash[:notice] = 'Action was successfully created.'
      redirect url(:actions, :edit, :id => @action.id)
    else
      render 'actions/new'
    end
  end

  get :edit, :with => :id do
    @action = Action.find(params[:id])
    render 'actions/edit'
  end

  put :update, :with => :id do
    @action = Action.find(params[:id])
    if @action.update_attributes(params[:action])
      flash[:notice] = 'Action was successfully updated.'
      redirect url(:actions, :edit, :id => @action.id)
    else
      render 'actions/edit'
    end
  end

  delete :destroy, :with => :id do
    action = Action.find(params[:id])
    if action.destroy
      flash[:notice] = 'Action was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Action!'
    end
    redirect url(:actions, :index)
  end
end
