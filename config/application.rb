require File.expand_path('../environment.rb', __FILE__)
%w{app/controllers app/helpers app/mailers app/models lib}.each do |dir|
  $LOAD_PATH.unshift(File.expand_path('../../' + dir, __FILE__))
  Dir[File.join(dir, '*.rb')].each{|file| require File.basename(file) }
end
