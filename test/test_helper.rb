ENV["RACK_ENV"] = "test"

require 'test/unit'
require 'rubygems'
require 'rack/test'
require File.join(File.expand_path('../../config/', __FILE__), 'boot.rb')
require File.join(File.expand_path('../../config/', __FILE__), 'application.rb')
require File.join(File.expand_path('../', __FILE__), 'factories.rb')

DatabaseCleaner.strategy = :truncation
Capybara.app = Application
Capybara.run_server = false

class Test::Unit::TestCase
  include Rack::Test::Methods
  include Capybara

  def app
    Application
  end

  def login(email, password)
    visit '/login'
    within('//form') do
      fill_in 'email', :with => email
      fill_in 'password', :with => password
    end
    click_button 'Login'
    @user_session = true
  end

  def logout
    @user_session = false
    visit '/logout'
  end

  def redirect_ok?
    follow_redirect!
    assert_equal 'http://example.org/', last_request.url
    assert last_response.ok?
  end
end
