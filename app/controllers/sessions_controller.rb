class Application
  get '/login' do
    redirect "/" if current_user
    haml :'sessions/login'
  end

  post '/sessions' do
    @user = User.authenticate(params[:email], params[:password])

    if @user
      session["user"] = @user.id
      redirect "/"
    else
      flash[:error] = "Invalid email or password."
      redirect "/"
    end
  end

  get '/logout' do
    authorize_user
    session["user"] = nil
    redirect "/login"
  end
end
