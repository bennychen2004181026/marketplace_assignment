class HomeController < ApplicationController
  def index
    @categories = Category.grouped_data
    @products = Product.available.page(params[:page] || 1).per_page(params[:per_page] || 12).order("id desc")
    @users = User.all
  end
end
