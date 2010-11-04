require File.expand_path('../config/boot.rb', __FILE__)

begin
  require 'vlad'
  Vlad.load(:scm => "git")
rescue LoadError
end

Dir[File.join('lib/tasks', '*.rake')].each {|file| load file }
