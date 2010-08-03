get '/users/login' do
  redirect "/" if current_user
  haml :users_login
end

post '/users/session' do
  @user = User.authenticate(params[:email], params[:password])

  if @user
    session["user"] = @user.id
    redirect "/mentions"
  else
    redirect "/"
  end
end

get '/users/logout' do
  authorize_user or authorize_admin
  session["user"] = nil
  haml :users_login
end

get '/users' do
  authorize_admin
  @users = User.order("created_at desc")
  haml :users
end

get '/users/new' do
  authorize_admin
  @user = User.new
  haml :users_new
end

post '/users' do
  authorize_admin
  parse_nested_params
  @user = User.new(params[:user])

  if @user.save
    redirect "/users"
  else
    redirect "/"
  end
end

get '/users/:id/edit' do
  authorize_admin
  @user = User.find params[:id]
  haml :users_edit
end

put '/users/:id' do
  authorize_admin
  parse_nested_params
  @user = User.find params[:id]

  if @user.update_attributes(params[:user])
    redirect "/users"
  else
    redirect "/"
  end
end

get '/users/:id' do
  authorize_admin
  @user = User.find params[:id]
  haml :users_show
end

delete '/users/:id' do
  authorize_admin
  @user = User.find params[:id]
  @user.destroy
  redirect "/users"
end
