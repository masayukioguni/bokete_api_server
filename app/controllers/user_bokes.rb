BoketeApiServer::App.controllers :user_bokes do  
  get :index do    
    q = params[:q]
    if q != nil
      @bokes = UserBoke.where("user_name like ? OR boke like ?", "%#{q}%","%#{q}%")
    else
      @bokes = UserBoke.all
    end
    render 'user_bokes/index'
  end
end
