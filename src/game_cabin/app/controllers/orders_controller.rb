class OrdersController < ApplicationController
   def new
    # Fetching the order related data
    get_categories_and_carts_num
   end
   def create
     
   end

end