require File.expand_path('../environment.rb', __FILE__)

autoload :Digest, 'digest/sha2'
%w{app/mailers app/models}.each do |dir|
  Dir[File.join(dir, '*.rb')].each do |file|
    autoload File.basename(file, '.rb').camelize.to_sym, File.join(Sinatrails.root, file.to_s).to_s
  end
end

%w{app/controllers app/helpers lib}.each do |dir|
  Dir[File.join(dir, '*.rb')].each{|file| require file }
end

