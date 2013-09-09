BoketeApiServer::Admin.controllers :bokes do
  get :index do
    @title = "Bokes"
    @bokes = Boke.all
    render 'bokes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'boke')
    @boke = Boke.new
    render 'bokes/new'
  end

  post :create do
    @boke = Boke.new(params[:boke])
    if @boke.save
      @title = pat(:create_title, :model => "boke #{@boke.id}")
      flash[:success] = pat(:create_success, :model => 'Boke')
      params[:save_and_continue] ? redirect(url(:bokes, :index)) : redirect(url(:bokes, :edit, :id => @boke.id))
    else
      @title = pat(:create_title, :model => 'boke')
      flash.now[:error] = pat(:create_error, :model => 'boke')
      render 'bokes/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "boke #{params[:id]}")
    @boke = Boke.find(params[:id])
    if @boke
      render 'bokes/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'boke', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "boke #{params[:id]}")
    @boke = Boke.find(params[:id])
    if @boke
      if @boke.update_attributes(params[:boke])
        flash[:success] = pat(:update_success, :model => 'Boke', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:bokes, :index)) :
          redirect(url(:bokes, :edit, :id => @boke.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'boke')
        render 'bokes/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'boke', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Bokes"
    boke = Boke.find(params[:id])
    if boke
      if boke.destroy
        flash[:success] = pat(:delete_success, :model => 'Boke', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'boke')
      end
      redirect url(:bokes, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'boke', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Bokes"
    unless params[:boke_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'boke')
      redirect(url(:bokes, :index))
    end
    ids = params[:boke_ids].split(',').map(&:strip)
    bokes = Boke.find(ids)
    
    if Boke.destroy bokes
    
      flash[:success] = pat(:destroy_many_success, :model => 'Bokes', :ids => "#{ids.to_sentence}")
    end
    redirect url(:bokes, :index)
  end
end
