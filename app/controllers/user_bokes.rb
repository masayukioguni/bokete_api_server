BoketeApiServer::App.controllers :user_bokes do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :index do    
    q = params[:q]
    if q != nil
      @bokes = UserBoke.where("user like ? OR boke like ?", "%#{q}%","%#{q}%")
    else
      @bokes = UserBoke.all
    end
    render 'user_bokes/index'
  end
end
