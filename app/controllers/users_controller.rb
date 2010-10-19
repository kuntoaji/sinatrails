class Application
  get '/users' do
    # Marker logger example
    Marker.mark "processing users" do
      authorize_admin
      @users = User.order("created_at desc").
        paginate :page => params[:page], :per_page => 10
    end

    haml :'users/index'
  end

  get '/users/new' do
    authorize_admin
    @user = User.new
    haml :'users/new'
  end

  post '/users' do
    authorize_admin
    @user = User.new(params[:user])

    if @user.save
      redirect "/users"
    else
      haml :'users/new'
    end
  end

  get '/users/:id/edit' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      haml :'users/edit'
    else
      haml :'shared/not_found'
    end
  end

  put '/users/:id' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      if @user.update_attributes(params[:user])
        redirect "/users"
      else
        haml :'users/edit'
      end
    else
      haml :'shared/not_found'
    end
  end

  get '/users/:id' do
    authorize_user
    @user = User.find_by_id params[:id]

    if @user
      haml :'users/show'
    else
      haml :'shared/not_found'
    end
  end

  delete '/users/:id' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      @user.destroy
      redirect "/users"
    else
      haml :'shared/not_found'
    end
  end
end
