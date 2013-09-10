BoketeApiServer::App.controllers :bokes do 
  get :index do
    @bokes = Boke.all(:order => 'created_at desc')
    render 'bokes/index'
  end
end
