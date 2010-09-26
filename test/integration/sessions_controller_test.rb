require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class SessionsControllerTest < Test::Unit::TestCase
 context "A user session" do
    setup do
      DatabaseCleaner.clean
      Factory.create(:user)
      @user = User.first
    end

    should "successfully login and logout" do 
      login @user.email, 'secret'
      assert page.has_content?('Logout')

      visit '/logout'
      assert page.has_content?('Login')
    end
  end
end
