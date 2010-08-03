desc "Populate dummy data"
task(:populate_dummy => :environment) do
  u = User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
    :name => "Dummy", :role => "admin")
end
