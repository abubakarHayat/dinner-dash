# frozen_string_literal: true

class ItemsController < ApplicationController
  include CurrentCart
  after_action :set_cart, only: [:add_to_cart]

  def index
    @items = Item.get_sold_items
    items_count = OrderItem.group(:item_id).count
    @popular_item = Item.find(items_count.key(items_count.values.max))
  rescue ActiveRecord::RecordNotFound
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
    @item = Item.find(params[:id])
    authorize @item
  end

  def update
    @item = Item.find(params[:id])
    authorize @item
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    authorize Item
  end

  def destroy
    @item = Item.find(params[:id])
    authorize @item
    @item.destroy

    redirect_to root_path, status: :see_other
  end

  def admin_show_items
    @items = Item.includes(:restaurant)
    authorize @items
  end

  def add_to_cart
    session[:cart] ||= {}
    if cartable?
      session[:cart][params[:id]] = if session[:cart][params[:id]].nil?
                                      1
                                    else
                                      session[:cart][params[:id]].to_i + 1
                                    end
      flash[:notice] = 'Item added to cart'
    else
      flash[:notice] = 'Item from 2 different restaurants cannot be added at the same time in the cart!'
    end
  end

  # def remove_cart_item
  #   if user_signed_in?
  #     CartItem.find_by!(cart_id: current_user.cart.id, item_id: params[:id]).destroy
  #   else
  #     session[:cart].delete(params[:id])
  #   end
  #   flash[:notice] = 'Item removed from cart'
  # end

  private

  def item_params
    params.require(:item).permit(:item_title, :item_description, :item_price, :restaurant_id, :image, :is_sold,
                                 category_ids: [])
  end

  def cartable?
    if user_signed_in? && !current_user.cart.items.first.nil?
      current_user.cart.items.first.restaurant_id == Item.find(params[:id]).restaurant_id

    elsif session[:cart].empty?
      true
    else
      item_id = session[:cart].keys[0]
      first_item = Item.where(id: item_id).pluck(:restaurant_id)
      current_item = Item.where(id: params[:id]).pluck(:restaurant_id)
      first_item == current_item
    end
  end
end
