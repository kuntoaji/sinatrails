desc "run application_test.rb"
task :test do
  ENV["RACK_ENV"] = "test"
  load "config/database.rb"
  load "test/application_test.rb"  
end
