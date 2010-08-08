desc "Populate dummy data"
task(:populate_dummy => 'db:load') do
  u = User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
    :name => "Ajijay", :role => "admin")
  FeedEntry.update_from_feed('http://feeds.feedburner.com/PaulDixExplainsNothing')
end
