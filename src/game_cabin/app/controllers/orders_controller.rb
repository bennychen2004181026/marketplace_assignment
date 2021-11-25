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
     
   end

end