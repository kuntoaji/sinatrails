class SessionTest < ApplicationTest
  def create_user
    User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")
  end

  def create_session
    post "/sessions", :email => "dummy@railsmine.net", :password => "secret"
    follow_redirect!
  end

  def test_users_session
    create_user
    create_session

    assert_equal "http://example.org/users", last_request.url
    assert true, last_response.ok?
  end

  def test_users_logout
    create_user
    create_session
    get "/logout"
    follow_redirect!

    assert_equal "http://example.org/login", last_request.url
    assert true, last_response.ok?
  end

  def test_admin_authorization
    get "/users"
    follow_redirect!

    assert_equal "http://example.org/", last_request.url
    assert true, last_response.ok?
  end
end
