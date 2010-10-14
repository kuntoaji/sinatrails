class Application < Sinatra::Base
  configure do
    env = ENV['RACK_ENV'] || 'development'
    Bundler.require env

    # require or autoload your custom class or library from here.
    autoload :QueryCaching, File.join(Sinatrails.root, 'lib/sinatrails/query_caching.rb')
    
    set :raise_errors, false 
    enable :sessions
    enable :logging

    disable :run
    enable :method_override
    use QueryCaching

    # download from http://memcached.org/, install,
    # run this command for development & test environment:
    # memcached -vv
    use Rack::Cache,
      :metastore   => 'memcached://localhost:11211/meta',
      :entitystore => 'memcached://localhost:11211/body'

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
