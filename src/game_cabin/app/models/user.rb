class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Two kind of user role

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  
  has_one :address , dependent: :destroy
  has_many :shopping_carts
  has_many :orders


  # When new user create, it's normal user account.
  # And it ensures all user records has an unique uuid
  def set_default_role
    self.role ||= :user
  end
  

  # helper for better name displaying

  def username
    email.split('@').first
  end
 
end
