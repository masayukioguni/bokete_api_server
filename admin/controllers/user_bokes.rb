BoketeApiServer::Admin.controllers :user_bokes do
  get :index do
    @title = "User_bokes"
    @user_bokes = UserBoke.all
    render 'user_bokes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'user_boke')
    @user_boke = UserBoke.new
    render 'user_bokes/new'
  end

  post :create do
    @user_boke = UserBoke.new(params[:user_boke])
    if @user_boke.save
      @title = pat(:create_title, :model => "user_boke #{@user_boke.id}")
      flash[:success] = pat(:create_success, :model => 'UserBoke')
      params[:save_and_continue] ? redirect(url(:user_bokes, :index)) : redirect(url(:user_bokes, :edit, :id => @user_boke.id))
    else
      @title = pat(:create_title, :model => 'user_boke')
      flash.now[:error] = pat(:create_error, :model => 'user_boke')
      render 'user_bokes/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "user_boke #{params[:id]}")
    @user_boke = UserBoke.find(params[:id])
    if @user_boke
      render 'user_bokes/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'user_boke', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "user_boke #{params[:id]}")
    @user_boke = UserBoke.find(params[:id])
    if @user_boke
      if @user_boke.update_attributes(params[:user_boke])
        flash[:success] = pat(:update_success, :model => 'User_boke', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:user_bokes, :index)) :
          redirect(url(:user_bokes, :edit, :id => @user_boke.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'user_boke')
        render 'user_bokes/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'user_boke', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "User_bokes"
    user_boke = UserBoke.find(params[:id])
    if user_boke
      if user_boke.destroy
        flash[:success] = pat(:delete_success, :model => 'User_boke', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'user_boke')
      end
      redirect url(:user_bokes, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'user_boke', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "User_bokes"
    unless params[:user_boke_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'user_boke')
      redirect(url(:user_bokes, :index))
    end
    ids = params[:user_boke_ids].split(',').map(&:strip)
    user_bokes = UserBoke.find(ids)
    
    if UserBoke.destroy user_bokes
    
      flash[:success] = pat(:destroy_many_success, :model => 'User_bokes', :ids => "#{ids.to_sentence}")
    end
    redirect url(:user_bokes, :index)
  end
end
