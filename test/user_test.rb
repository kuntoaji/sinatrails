class UserTest < ApplicationTest
  def test_create_users
    user = User.create!(:email => "dummy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")

    assert_not_nil user
    assert_equal user.name, "Ajijay"
  end

  def test_update_users
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
    user = User.create!(:email => "dummydestroy@railsmine.net", :password => "secret", :password_confirmation => "secret",
      :name => "Ajijay", :role => "admin")
    user = User.find_by_name "Ajijay"
    id = user.id
    user.destroy
    user2 = User.find_by_id id
    assert_nil user2
  end
end
