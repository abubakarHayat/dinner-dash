class ItemsController < ApplicationController


  def index
    @items = Item.includes(:restaurant)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.includes(:restaurant).find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to root_path, status: :see_other
  end

  def admin_show_items
    @items = Item.includes(:restaurant)
  end

  private
    def item_params
      params.require(:item).permit(:item_title, :item_description, :item_price, :restaurant_id)
    end
end
