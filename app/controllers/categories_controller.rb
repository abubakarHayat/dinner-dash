# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]

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
    authorize Category
    @category_items = Item.where(id: CategoryItem.where(category_id: params[:id]).pluck(:item_id), is_sold: true)
  end

  def destroy
    authorize @category

    if @category.destroy
      flash[:alert] = 'Category deleted!'
      redirect_to show_categories_admins_path, status: :see_other
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
