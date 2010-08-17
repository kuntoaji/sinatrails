namespace :db do
  # http://github.com/rails/rails/raw/master/activerecord/lib/active_record/railties/databases.rake 
  task :load do
    require 'sinatra'
    require 'active_record'
    require 'logger'
    require File.join(File.expand_path('../../../', __FILE__), 'config', 'environment.rb')
  end

  desc "Migrate the database"
  task(:migrate => :load) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
