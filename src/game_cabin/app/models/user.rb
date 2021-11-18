class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Two kind of user role

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?


  # When new user create, it's normal user account

  def set_default_role
    self.role ||= :user
  end

  # helper for better name displaying

  def username
    email.split('@').first
  end

end
