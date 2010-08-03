#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra' # 1.0.0
#require 'haml'
require 'active_record' # 3.0.0.rc
require 'digest/sha2'
require 'yaml'
#require 'logger'

%w{config app/controllers app/helpers app/models lib}.each do |dir|
  $LOAD_PATH.unshift(dir)
  Dir[File.join(dir, "*.rb")].each {|file| require File.basename(file) }
end

include Sinatrails::Authorization
enable :sessions
set :views, File.dirname(__FILE__) + '/app/views'
