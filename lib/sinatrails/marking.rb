# http://pivotallabs.com/users/alex/blog/articles/1232-basic-ruby-webapp-performance-tuning-rails-or-sinatra-

class Marking
  def initialize(app)
    @app = app
  end

  def call(env)
    response = nil
    Marker.mark("#{env['REQUEST_METHOD']} #{env['SCRIPT_NAME']}#{env['PATH_INFO']}") do
      response = @app.call(env)
    end
    response
  end
end
