EnovaPoker.controllers :tournament do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  # Player wants to register for a tournament
  # Posts: name:string, hostname:uri
  # Response: 200 - player is registered
  # Response: 404 - No tournaments active
  post :register do
    tournament = Tournament.find(:last)
    if tournament && Player.new(:name => params[:name], :hostname => params[:hostname], :tournament => tournament).save
      status 200
      body "Welcome to the party!"
    else
      status 404
      body "No active tournaments"
    end
  end
  
end
