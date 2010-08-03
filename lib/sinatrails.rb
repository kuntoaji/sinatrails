module Sinatrails
  module Authorization
    def current_user
      user = User.find_by_id session["user"]
      return user
    end

    def authorize_user
      redirect "/" unless current_user
    end

    def authorize_admin
      redirect "/" unless current_user.try(:admin?)
    end
  end

  module Test
    def destroy_all_users
      users = User.all
      users.each{|u| u.destroy}
    end
  end
end
