class DeliveryDetailsController < ApplicationController

  # Only display the Order information
  layout false

  def index
    @delivery_details = current_user.delivery_details
  end

  def new
    @delivery_detail = current_user.delivery_details.new
  end

  def set_default_address
    
  end

end
