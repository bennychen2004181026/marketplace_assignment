class OrdersController < ApplicationController
   def new
    # Fetching the order related data
    get_categories_and_carts_num
    @address = current_user.address
   end
   def create
     
   end

end