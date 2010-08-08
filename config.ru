require 'application.rb'

#$LOGGER = ActiveSupport::BufferedLogger.new("log/#{ENV['RACK_ENV']}.log")
#$LOGGER.auto_flushing = 10

# source: http://stackoverflow.com/questions/2239240/use-rackcommonlogger-in-sinatra
#use Rack::CommonLogger, $LOGGER

run Sinatra::Application
