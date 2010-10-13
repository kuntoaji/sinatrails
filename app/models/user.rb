class User < ActiveRecord::Base
  extend WillPaginate::Finders::Base

  attr_accessor :password, :password_confirmation

  validates :email, 
    :presence => true,
    :uniqueness => true,
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is not formatted properly"}

  validates :password,
    :length => {:minimum => 6},
    :confirmation => true,
    :unless => lambda{|u| u.password.blank?}

  validates :password_confirmation, 
    :presence => true,
    :unless => lambda{|u| u.password.blank?}

  validates :name, :role, :presence => true
  before_save :hash_password, :unless => lambda{|u| u.password.blank?}

  def self.authenticate(email, password)
    if user = find_by_email(email)
      if user.encrypted_password == Digest::SHA512.hexdigest(user.password_salt + password)
	      return user
      end
    end

    return nil
  end

  def admin?
    self.role == "admin"
  end

  def member?
    self.role == "member"
  end

  private
  def hash_password
    self.password_salt = ActiveSupport::SecureRandom.base64(12)
    self.encrypted_password = Digest::SHA512.hexdigest(self.password_salt + self.password)
  end
end
