class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Two kind of user role

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  # The AddressType module helper can identify which type of the address is, it can be residential or postage one.
  # The scope can help identifing user's residential address.
  has_many :delivery_details, -> { where(address_type: DeliveryDetail::AddressType::Residential).order("id desc") }
  
  has_one :default_address, class_name: :DeliveryDetail,:foreign_key => 'default_address_id'
  has_many :shopping_carts

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
