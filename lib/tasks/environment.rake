task :environment do
  ENV["RACK_ENV"] ||= "development"
end
