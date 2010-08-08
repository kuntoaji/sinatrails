class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods
  include Sinatrails::Test

  def app
    Sinatra::Application
  end

  def test_default
    clean_db
    get "/"
  end

  def test_users_session
    clean_db
    User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")

    post "/sessions", :email => "dummy@railsmine.net", :password => "secret"
    follow_redirect!

    assert_equal "http://example.org/users", last_request.url
    assert true, last_response.ok?
  end

  def test_users_logout
    clean_db
    test_users_session
    get "/logout"
    follow_redirect!

    assert_equal "http://example.org/login", last_request.url
    assert true, last_response.ok?
  end

  def test_admin_authorization
    clean_db
    get "/users"
    follow_redirect!

    assert_equal "http://example.org/", last_request.url
    assert true, last_response.ok?
  end

  #def test_post_users
  #  clean_db
  #  params = {:user => {:email => "dummypost@railsmine.net", :password => "secret", 
  #    :password_confirmation => "secret", :name => "Ajijaypost", :role => "admin"}}
  #
  #  post "/users", params
  #  follow_redirect!
  #  user = User.find_by_name "Ajijaypost"
  #  assert_not_nil user
  #  assert_equal user.name, "Ajijaypost"
  #  assert_equal "http://example.org/users", last_request.url
  #  assert true, last_response.ok?
  #end

  def test_create_users
    clean_db
    user = User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")

    assert_not_nil user
    assert_equal user.name, "Ajijay"
  end

  def test_update_users
    clean_db
    user = User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")

    user = User.find_by_name "Ajijay"
    user.name = "Perkedel"
    user.save!

    assert_equal user.name, "Perkedel"
    user.name = "Ajijay"
    user.save!
    assert_equal user.name, "Ajijay"
  end

  def test_destroy_users
    clean_db
    user = User.create!(:email => "dummydestroy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")
    user = User.find_by_name "Ajijay"
    id = user.id
    user.destroy
    user2 = User.find_by_id id
    assert_nil user2
  end
