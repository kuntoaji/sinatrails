desc "Populate dummy data"
task(:populate_dummy => 'db:load_config') do
  require 'will_paginate/finders/base'
  require File.join(File.expand_path('../../../', __FILE__), 'app', 'models', 'user.rb')
  15.times do |i|
    u = User.create!(:email => "dummy#{i}@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Dummy no. #{i}", :role => "admin")
  end
end
