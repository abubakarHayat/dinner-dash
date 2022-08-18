class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    authorize Category
    @category_items = Item.where(id: CategoryItem.where(category_id: params[:id]).pluck(:item_id), is_sold: true)
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.destroy

    redirect_to categories_path, status: :see_other
  end

  def admin_show_categories
    @categories = Category.all
    authorize @categories
  end

  private

    def category_params
      params.require(:category).permit(:category_name)
    end

end
