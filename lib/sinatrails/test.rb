module Sinatrails
  module Test
    def destroy_all_users
      users = User.all
      users.each{|u| u.destroy}
    end
  end
end
