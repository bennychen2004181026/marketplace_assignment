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

  def new
    @category = Category.new
    @root_categories = Category.roots.order(id: 'desc')
  end

  def create
    @category = Category.new(params.require(:category).permit(:title,:weight,:products_quantity,:ancestry))
    @root_categories = Category.roots.order(id: 'desc')
    if @category.save
      flash[:notice] = "Successfully saved"
      redirect_to admin_categories_path
    else
      # Re initializing a new Category
      render action: :new
    end
  end
end
