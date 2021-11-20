class Cart < ApplicationRecord
  validates :user_uuid, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  belongs_to :product
  belongs_to :user
# For searching all the shopping carts that the user has.
scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

# Thi method is defined for cart controller. '**'represent the argument is a hash.
# Cart attributes has uuid, product id and amount of this item.
def self.create_or_update!(**cart_attributes)
  # To identify which cart I want to update or creat, I need to fetch the current user uuid and product.
  current_con = {
    user_uuid: cart_attributes[:user_uuid],
    product_id: cart_attributes[:product_id]
  }
  # 'First' is for searching the newest record of this cart.
  record = where(current_con).first
  # if has a match newest record, it means the cart is already create and this product's 'add to cart' 
  # button is already been clicked, then update the attributes
  if record
    # Updating the record amount attribute by using hash merge and update! method to save in database.
    # The exclamation point means when somthing wrong happen, an exception will be arised.
    record.update!(cart_attributes.merge(amount: record.amount + cart_attributes[:amount]))
  else
    # If can't find a match one, then create a new one with the attributes hash and save!.
    record = create!(cart_attributes)
  end
  # Return the new record
  record
end
end
