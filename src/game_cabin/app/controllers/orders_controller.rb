class OrdersController < ApplicationController
   def new
    # Fetching the order related data
    get_categories_and_carts_num
    @address = current_user.address
    # Fetch shopping carts from shopping cart model including the product image.
    @shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid)
      .order("id desc").includes(product: :product_image_attachment)
   end
   
  def create
  # Apply shopping cart model scope method by_user_uuid to help identify which shopping 
  # carts' has the same uuid  as current user's uuid and includes corresponding product records 
  # for order invoking.
   shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).includes(:product)
   # In case the reccords are empty, redirect to shopping cart index path.
   if shopping_carts.blank?
     redirect_to shopping_carts_path
     return
   end
   # fetch the address that order will need by user association with address.
   address = current_user.address
   # Define a helper in Order model to gather all the records that needed in Order checkout page.
   begin
   orders = Order.create_order_from_shopping_carts!(current_user, address, shopping_carts)
   # Because this transaction mehod being implemented in the create_order_from_shopping_carts! is at high risk, so
   # apply a rescue if the ActiveRecord::Rollback is called and display the error message
   rescue ActiveRecord::Rollback => e
      puts "Sorry your transaction failed. Reason: #{e}"
   end
   redirect_to root_path
 end

end