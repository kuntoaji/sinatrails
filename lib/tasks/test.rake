desc "run application_test.rb"
task :test do
  #require 'rack/test'
  require 'test/unit'
  #Bundler.require(:test)
  require 'database_cleaner'

  ENV["RACK_ENV"] = "test"
  DatabaseCleaner.strategy = :truncation

  load "config/database.rb"
  load "test/application_test.rb"  
end

