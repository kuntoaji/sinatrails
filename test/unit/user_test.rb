require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class UserTest < Test::Unit::TestCase
  context "On create a user" do
    setup do
      DatabaseCleaner.clean
      @user = User.new(Factory.attributes_for(:user))
    end

    should "return true" do
      assert @user.save
    end
  end

  context "A User instance" do
    setup do
      DatabaseCleaner.clean
      Factory.create(:user)
      @user = User.first
    end

    should "not nil and return its name" do
      assert_not_nil @user
      assert_equal @user.name, "Myname"
    end

    should "successfully destroyed" do
      assert_not_equal 0, User.count
      @user.destroy
      assert_equal 0, User.count
    end

    context "on update" do
      setup do
        @user.name = "Foo"
      end

      should "return true" do
        assert @user.save
      end

      context "with new name" do
        setup do
          @user.save
        end

        should "return its new name" do
          assert_equal "Foo", @user.name
        end
      end
    end
  end
end
