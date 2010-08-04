get '/login' do
  redirect "/" if current_user
  haml :sessions_new
end

post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])

  if @user
    session["user"] = @user.id
    redirect "/users"
  else
    redirect "/"
  end
end

get '/logout' do
  authorize_user or authorize_admin
  session["user"] = nil
  redirect "/login"
end
