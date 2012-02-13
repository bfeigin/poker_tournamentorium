Admin.controllers :hands do

  get :index do
    @hands = Hand.all
    render 'hands/index'
  end

  get :new do
    @hand = Hand.new
    render 'hands/new'
  end

  post :create do
    @hand = Hand.new(params[:hand])
    if @hand.save
      flash[:notice] = 'Hand was successfully created.'
      redirect url(:hands, :edit, :id => @hand.id)
    else
      render 'hands/new'
    end
  end

  get :edit, :with => :id do
    @hand = Hand.find(params[:id])
    render 'hands/edit'
  end

  put :update, :with => :id do
    @hand = Hand.find(params[:id])
    if @hand.update_attributes(params[:hand])
      flash[:notice] = 'Hand was successfully updated.'
      redirect url(:hands, :edit, :id => @hand.id)
    else
      render 'hands/edit'
    end
  end

  delete :destroy, :with => :id do
    hand = Hand.find(params[:id])
    if hand.destroy
      flash[:notice] = 'Hand was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Hand!'
    end
    redirect url(:hands, :index)
  end
end
