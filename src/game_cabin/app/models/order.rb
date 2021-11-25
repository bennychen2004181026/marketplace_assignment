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

    # It robably has many shopping carts, so it will be an array parameter
    def self.create_order_from_shopping_carts! user, address, *shopping_carts

       # Using array flatten method to make it into a flattening array for access each shopping cart easily.
        shopping_carts.flatten!
        
       # Declear an empty orders array to contain all the order record
        orders = []
       # Transactions are protective blocks where SQL statements are only permanent if they can all succeed as one atomic action. 
       # Transactions enforce the integrity of the database and guard the data against program errors or database break-downs.
       # To ensure the atomicity, consistency, isolation, and durability which are ACID stands for in a database system, 
       # transaction is needed for isloate the block form the database and once there is exception arising, it will be rolled back 
       # immediately  to ensure the database integrity, becasue we are manipulating many model's records here.
        transaction do
       # For each shopping cart in the shopping carts array, produce each order record with necessory data
       # product data can be fetched from the relationship with shopping cart, one user has one address,
       # the order and shopping cart's relationship is designed to be one to one, so in one order only contains
       # one kind of items and the amount is the same as the amount in shopping cart
            shopping_carts.each do |shopping_cart|
       # Exclamation point is informing the hish rish of data manipulation and if exception is thrown, transaction
       # will roll back the process at once.
              orders << user.orders.create!(
                product: shopping_cart.product,
                address: address,
                amount: shopping_cart.amount,
                total_payment: shopping_cart.amount * shopping_cart.product.price
              )
            end
          # Because the required records are integrated into orders array alreay, the shopping carts data is no longer needed,
          # to minimize the pollution to database, apply destory method call on the shopping_carts array which comes 
          # from the flatten behavior.
          # Again, if  before_destroy callback throws :abort the action is cancelled and destroy! raises 
          # ActiveRecord::RecordNotDestroyed exception.
          destroy!(shopping_carts)
          end
         # Returns the orders array
          orders
        end

    private
    def gen_order_no
        # Rails 6 method for generate a Version 4 UUIDs.
        self.order_no = SecureRandom.base36(24)
    end
end
