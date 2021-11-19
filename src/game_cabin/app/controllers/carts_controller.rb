class CartsController < ApplicationController

  def index
    get_categories_and_carts_num
    # Inovke the scope method define in cart model to fetch all the carts that belongs to user has
    @carts = Cart.by_user_uuid(session[:user_uuid])
      .order('id DESC').includes([:product => [:product_image]])
  end


end
