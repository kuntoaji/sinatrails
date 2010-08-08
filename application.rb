require 'rubygems'
require 'bundler/setup'

#Bundler.require(:default)
require 'sinatra'
require 'haml'
require 'active_record'
require 'feedzirra'
require 'daemons'
require 'yaml'
require 'digest/sha2'

enable :sessions
enable :logging
set :views, File.dirname(__FILE__) + '/app/views'

%w{config app/controllers app/helpers app/models lib}.each do |dir|
  $LOAD_PATH.unshift(dir)
  Dir[File.join(dir, '*.rb')].each{|file| require File.basename(file) }
end

include Sinatrails::Authorization

