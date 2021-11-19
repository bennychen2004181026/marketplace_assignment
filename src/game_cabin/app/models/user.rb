class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Two kind of user role

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  before_create :set_user_uuid

  # When new user create, it's normal user account.
  # And it ensures all user records has an unique uuid
  def set_default_role
    self.role ||= :user
  end
  

  # helper for better name displaying

  def username
    email.split('@').first
  end
  private
  def set_user_uuid
    self.uuid = SecureRandom.base36(24)
  end
end
