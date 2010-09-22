require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class SessionsControllerTest < Test::Unit::TestCase
  def setup
    DatabaseCleaner.clean
    Factory.create(:user)
    @user = User.first
  end

  def test_login_logout
    login @user.email, 'secret'
    assert page.has_content?('Logout')

    visit '/logout'
    assert page.has_content?('Login')
  end
end
