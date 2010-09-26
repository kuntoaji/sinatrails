require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class UsersControllerTest < Test::Unit::TestCase
  context "on access user's resources" do
    setup do
      DatabaseCleaner.clean
      Factory.create(:user)
      @admin = User.first
      attrs = Factory.attributes_for(:user)
      @client = User.new(attrs)
      @client.role = "client"
      @client.save
    end

    teardown do
      logout if @user_session
    end

    should "be redirected to homepage on GET /users if not logged in" do
      get '/users'
      follow_redirect!
      assert_equal 'http://example.org/', last_request.url
      assert last_response.ok?
    end

    should "success on GET /users" do
      login @admin.email, 'secret'
      visit '/users'
      assert page.has_content?('Users')
      assert page.has_css?('table')
    end

    should "be redirected to homepage on GET /users/new if not logged in" do
      get '/users/new'
      follow_redirect!
      assert_equal 'http://example.org/', last_request.url
      assert last_response.ok?
    end

    should "success on GET /users/new" do
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

    should "be redirected to homepage on GET /users/:id/edit if not logged in" do
      get "/users/#{@client.id}/edit"
      follow_redirect!
      assert_equal 'http://example.org/', last_request.url
      assert last_response.ok?
    end

    should "success on GET /users/:id/edit" do
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

    should "be redirected to homepage on GET /users/:id if not logged in" do
      get "/users/#{@client.id}"
      follow_redirect!
      assert_equal 'http://example.org/', last_request.url
      assert last_response.ok?
    end

    should "success on GET /users/:id" do
      login @admin.email, 'secret'
      visit "/users/#{@client.id}"
      assert page.has_content?('User profile')
    end
  end
end
