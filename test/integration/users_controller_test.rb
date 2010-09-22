require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class UsersControllerTest < Test::Unit::TestCase
  def setup
    DatabaseCleaner.clean
    Factory.create(:user)
    @admin = User.first
    attrs = Factory.attributes_for(:user)
    @client = User.new(attrs)
    @client.role = "client"
    @client.save
  end

  def teardown
    logout if @user_session
  end

  def test_index_users_before_login
    get '/users'
    follow_redirect!
    assert_equal 'http://example.org/', last_request.url
    assert last_response.ok?
  end

  def test_index_users_after_login
    login @admin.email, 'secret'
    visit '/users'
    assert page.has_content?('Users')
    assert page.has_css?('table')
  end

  def test_new_users_before_login
    get '/users/new'
    follow_redirect!
    assert_equal 'http://example.org/', last_request.url
    assert last_response.ok?
  end

  def test_new_users_after_login
    login @admin.email, 'secret'
    visit '/users/new'
    assert page.has_content?('Account details')
    assert page.has_css?('form')
    within('//form') do
      fill_in 'user[email]', :with => 'dummy@railsmine.net'
      fill_in 'user[password]', :with => '123456'
      fill_in 'user[password_confirmation]', :with => '123456'
      fill_in 'user[name]', :with => 'myname'
    end
    click_button 'Save'

    user = User.find_by_email 'dummy@railsmine.net'
    assert user
  end

  def test_edit_users_before_login
    get "/users/#{@client.id}/edit"
    follow_redirect!
    assert_equal 'http://example.org/', last_request.url
    assert last_response.ok?
  end

  def test_edit_users_after_login
    login @admin.email, 'secret'
    visit "/users/#{@client.id}/edit"
    #save_and_open_page
    assert page.has_content?('Account details')
    assert page.has_css?('form')
    within('//form') do
      fill_in 'user[name]', :with => 'myname edit'
    end
    click_button 'Save'

    @client.reload
    assert_equal 'myname edit', @client.name
  end

  def test_show_users_before_login
    get "/users/#{@client.id}"
    follow_redirect!
    assert_equal 'http://example.org/', last_request.url
    assert last_response.ok?
  end

  def test_show_users_after_login
    login @admin.email, 'secret'
    visit "/users/#{@client.id}"
    assert page.has_content?('User profile')
  end
end
