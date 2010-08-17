Dir[File.join(File.expand_path('../', __FILE__), 'sinatrails', '*.rb')].each{|file| require file }

class Application
  include Sinatrails::Authorization
end
