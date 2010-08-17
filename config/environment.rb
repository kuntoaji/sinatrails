class Application
  ActiveRecord::Base.configurations = YAML::load(File.open('config/database.yml'))

  configure :production do
    Bundler.require :production
    disable :reload
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['production'])
  end

  configure :development do
    Bundler.require :development
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
  end

  configure :test do
    Bundler.require :test
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
  end
end
