ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))['development']) if development?
ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))['test']) if test?
ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))['production']) if production?
