#require 'rake'
#require 'rake/testtask'
#require 'rake/rdoctask'
require 'rubygems'
require 'bundler/setup'

begin
  require 'vlad'
  Vlad.load(:scm => "git")
rescue LoadError
end

Dir[File.join('lib/tasks', '*.rake')].each {|file| load file }
