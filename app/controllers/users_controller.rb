class Application
  get '/users' do
    authorize_admin
    @users = User.order("created_at desc").
      paginate :page => params[:page], :per_page => 10
    haml :users
  end

  get '/users/new' do
    authorize_admin
    @user = User.new
    haml :users_new
  end

  post '/users' do
    authorize_admin
    @user = User.new(params[:user])

    if @user.save
      redirect "/users"
    else
      redirect "/"
    end
  end

  get '/users/:id/edit' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      haml :users_edit
    else
      haml :not_found
    end
  end

  put '/users/:id' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      if @user.update_attributes(params[:user])
        redirect "/users"
      else
        redirect "/"
      end
    else
      haml :not_found
    end
  end

  get '/users/:id' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      haml :users_show
    else
      haml :not_found
    end
  end

  delete '/users/:id' do
    authorize_admin
    @user = User.find_by_id params[:id]

    if @user
      @user.destroy
      redirect "/users"
    else
      haml :not_found
    end
  end
end
