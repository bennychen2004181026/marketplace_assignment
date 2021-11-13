class User < ApplicationRecord
  # Provide access to password and comfirmation
  attr_accessor :password, :password_comfirmation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validate the arributes
  # For email
  validates :email, presence: { message: "must be given please" } 
  validates :email, uniqueness: { message: "already exists" }

  # For password
  validates :password, presence: { message: "must be given please" },
  if: :need_validate_password
  validates :password_comfirmation, presence: { message: "must be given please" },
  if: :need_validate_password
  validates :password, confirmation: { message: "must be consistent" },
  if: :need_validate_password
  validates :password, length: { minimum: 8, message: "minimum 8 characters" },
  if: :need_validate_password

  private
  # helper method for when only changing the password
  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end

end
