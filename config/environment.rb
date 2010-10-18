class Application < Sinatra::Base
  configure do
    env = ENV['RACK_ENV'] || 'development'
    Bundler.require env

    set :raise_errors, false 
    enable :sessions
    enable :logging
    disable :run
    enable :method_override
    use QueryCaching
    use Marking

    # download from http://memcached.org/, install,
    # run this command for development & test environment:
    # memcached -vv
    # uncomment below to use Rack::Cache with memcached
    #
    #use Rack::Cache,
    #  :metastore   => 'memcached://localhost:11211/meta',
    #  :entitystore => 'memcached://localhost:11211/body'

    use Rack::Flash, :sweep => true
    set :views, Sinatrails.views
    set :root, Sinatrails.root

    ActiveRecord::Base.configurations = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[env])

    # Sending via GMail
    Mail.defaults do
      delivery_method :smtp, { :address              => "smtp.gmail.com",
                               :port                 => 587,
                               :domain               => 'example.com',
                               :user_name            => 'yourusername',
                               :password             => 'yourpassword',
                               :authentication       => 'plain',
                               :enable_starttls_auto => true  }
    end
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
