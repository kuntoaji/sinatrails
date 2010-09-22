require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class UserTest < Test::Unit::TestCase
  def setup
    DatabaseCleaner.clean
  end

  def test_create_users
    user = Factory.create(:user)
    assert_not_nil user
    assert_equal user.name, "Myname"
  end

  def test_update_users
    Factory.create(:user)

    user = User.find_by_name "Myname"
    user.name = "Foo"
    user.save!

    assert_equal user.name, "Foo"
    user.name = "Myname"
    user.save!
    assert_equal user.name, "Myname"
  end

  def test_destroy_users
    Factory.create(:user)
    user = User.first
    assert_not_equal 0, User.count
    user.destroy
    assert_equal 0, User.count
  end
end
