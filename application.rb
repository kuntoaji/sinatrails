class Application < Sinatra::Base
  configure do
    enable :sessions
    enable :logging
    disable :run
    enable :method_override
  
    set :views, File.dirname(__FILE__) + '/app/views'
    set :root, File.dirname(__FILE__)
  end
end

require 'config/environment.rb'
%w{app/controllers app/helpers app/models lib}.each do |dir|
  $LOAD_PATH.unshift(dir)
  Dir[File.join(dir, '*.rb')].each{|file| require File.basename(file) }
end

