class ProductsController < ApplicationController



  def show
    # Beacuse products controllers is inherited from application controller 
    # and I invoke can this method from application controller
     # And there is another invoke needed in the categories controller as well,
    # so I choose define the method in application controller rather than using 
    # before_action method.
    get_categories_and_carts_num
    @product = Product.find(params[:id])
  end


end
