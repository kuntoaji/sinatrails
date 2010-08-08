ActiveRecord::Base.configurations = YAML::load(File.open('config/database.yml'))

if production?
  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['production'])
elsif development?
  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
elsif test?
  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
end

