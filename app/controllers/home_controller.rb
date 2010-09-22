class Application
  get '/' do
    if current_user
      haml :'home/index'
    else
      haml :'sessions/login'
    end
  end
end
