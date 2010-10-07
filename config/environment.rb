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

    # Delivering the email
    # 
    # Once you have the settings right, sending the email is done by:
    # 
    #   Mail.deliver do
    #     to 'yourname@example.org'
    #     from 'hisname@example.net'
    #     subject 'testing email'
    #     body 'testing email'
    #   end
    #
    # Or
    #
    # Mail.deliver do
    #   to 'yourname@example.org'
    #   from 'Example Name <hisname@example.net>'
    #   subject 'First multipart email sent with Mail'
    #
    #   text_part do
    #     body 'This is plain text'
    #   end
    #
    #   html_part do
    #     content_type 'text/html; charset=UTF-8'
    #     body '<h1>This is HTML</h1>'
    #   end
    # end
    # 
    # Or by calling deliver on a Mail message
    # 
    #   mail = Mail.new do
    #     to 'yourname@example.org'
    #     from 'hisname@example.net'
    #     subject 'testing email'
    #     body 'testing email'
    #   end
    # 
    #   mail.deliver!
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
