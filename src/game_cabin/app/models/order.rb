class Order < ApplicationRecord
    validates :order_no, uniqueness: { message: "Order No shoulbe be unique!" }
    validates :order_no, presence: { message: "Order No shoulbe be provide!" }
    validates :total_amount, presence: { message: "Products total amount should exists." }
    validates :total_payment, presence: { message: "Total price should be provided" }
    validates :payment_at, presence: { message: "The date time of payment made should be provided." }

    belongs_to :user
    belongs_to :address
    belongs_to :product

    has_many :shopping_carts
    # Generating unique order No string for orders
    before_create :gen_order_no



    private
    def gen_order_no
        # Rails 6 method for generate a Version 4 UUIDs.
        self.order_no = SecureRandom.base36(24)
    end
end
