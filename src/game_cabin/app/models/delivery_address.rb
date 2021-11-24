class DeliveryAddress < ApplicationRecord
    validates :street_address, presence: { message: "Street detail address is needed!" }
    validates :suburb, presence: { message: "Address suburb is needed!" }
    validates :state, presence: { message: "Address State is needed!" }
    validates :postcode, presence: { message: "Postcode is needed!" }
end
