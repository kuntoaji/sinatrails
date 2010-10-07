class Application
  configure do
    set :raise_errors, false 
    enable :sessions
    enable :logging

    disable :run
    enable :method_override
    use Rack::Flash, :sweep => true

    set :views, Sinatrails.views
    set :root, Sinatrails.root

    env = ENV['RACK_ENV'] || 'development'
    Bundler.require env

    ActiveRecord::Base.configurations = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[env])
  end

  configure :production do
    disable :reload
  end

  configure :development do
    require 'new_relic/rack_app'
    use NewRelic::Rack::DeveloperMode

    enable :show_exceptions
  end
end
