require 'rubygems'

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
  Bundler.require :default

  class Sinatrails
    def self.root
      File.expand_path('../../', __FILE__)
    end

    def self.public
      File.expand_path('../../public/', __FILE__)
    end

    def self.views
      File.expand_path('../../app/views/', __FILE__)
    end
  end
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)
