namespace :db do
  # http://github.com/rails/rails/raw/master/activerecord/lib/active_record/railties/databases.rake 
  task :load do
    load 'config/database.rb'
  end

  desc "Migrate the database"
  task(:migrate => :load) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end

