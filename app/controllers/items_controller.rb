# frozen_string_literal: true

class ItemsController < ApplicationController
  include CurrentCart
  include ItemsHelper
  after_action :set_cart, only: [:add_to_cart]
  before_action :set_item, only: %i[edit update show destroy]

  def index
    @items = Item.sold_items
    items_count = OrderItem.group(:item_id).count
    @popular_item = Item.find(items_count.key(items_count.values.max))
    respond_to do |format|
      format.html
      format.json
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'No items to display!'
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    if @item.save
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @item
  end

  def update
    authorize @item
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    # authorize Item
  end

  def destroy
    authorize @item
    if @item.destroy
      flash[:alert] = 'Item deleted!'
      redirect_to show_items_admins_path, status: :see_other
    else
      render :index, status: :unprocessable_entity
    end
  end

  def add_to_cart
    session[:cart] ||= {}
    if cartable?
      make_cart_for_items
    else
      flash[:notice] = 'Item from 2 different restaurants cannot be added at the same time in the cart!'
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_title, :item_description, :item_price, :restaurant_id, :image, :is_sold,
                                 category_ids: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def cartable?
    if user_signed_in? && !current_user.cart.items.first.nil?
      check_cartable_authenticated
    elsif session[:cart].empty?
      true
    else
      check_cartable_unauthenticated
    end
  end
end
