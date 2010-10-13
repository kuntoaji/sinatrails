# a Rack middleware component that enables ActiveRecord query caching
# To use, put "use QueryCaching" in your Sinatra app.
# http://pivotallabs.com/users/alex/blog/articles/1232-basic-ruby-webapp-performance-tuning-rails-or-sinatra-

class QueryCaching 
  def initialize(app)
    @app = app
  end

  def call(env)
    if is_static_file?(env)
      @app.call(env)
    else
      response = nil
      ActiveRecord::Base.cache do
        response = @app.call(env)
      end
      response
    end
  end

  def is_static_file?(env)
     # if the path end with a dot-extension (e.g. 'foo.jpg') then we assume
     # it's a static file and don't enable the query cache. (This will only
     # work for some application URL schemes, naturally.)
    env['PATH_INFO'] =~ /\/[^\/]*.[^\/.]+$/
  end

end
