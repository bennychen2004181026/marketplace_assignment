class Admin::CategoriesController < Admin::BaseController
  def index
    # Classification with pagination and sort them in descending order
    if params[:id].blank?
      @categories = Category.roots
    else
      @category = Category.find(params[:id])
      @categories = @category.children
    end

    @categories = @categories.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order(id: "desc")
  end
end
