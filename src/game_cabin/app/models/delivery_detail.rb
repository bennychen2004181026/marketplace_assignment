class DeliveryDetail < ApplicationRecord
    validates :user_id, presence: true
    validates :address_type, presence: true
    validates :contact_name, presence: { message: "The buyer shoulld has a name" }
    validates :phone, presence: { message: "Need a phone number to contact" }
   
  
end
