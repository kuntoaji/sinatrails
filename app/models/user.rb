class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  validates :email, :name, :role, :presence => true
  validates_uniqueness_of :email
  validates_confirmation_of :password_confirmation, :if => :password_is_not_blank?
  before_save :hash_password, :if => :password_is_not_blank?

  def self.authenticate(email, password)
    if user = find_by_email(email)
      if user.encrypted_password == Digest::SHA2.hexdigest(user.password_salt + password)
	return user
      end
    end

    return nil
  end

  def password_is_not_blank?
    !self.password.blank?
  end

  def admin?
    self.role == "admin"
  end

  private

  def hash_password
    self.password_salt = ActiveSupport::SecureRandom.base64(8)
    self.encrypted_password = Digest::SHA2.hexdigest(self.password_salt + self.password)
  end
end
