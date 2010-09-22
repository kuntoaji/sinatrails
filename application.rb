class Application < Sinatra::Base
end

require File.expand_path('../config/environment.rb', __FILE__)
%w{app/controllers app/helpers app/models lib}.each do |dir|
  $LOAD_PATH.unshift(dir)
  Dir[File.join(dir, '*.rb')].each{|file| require File.basename(file) }
end
