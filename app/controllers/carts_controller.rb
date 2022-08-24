# frozen_string_literal: true

class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart
 # after_action :calc_cart_total, only: [:remove_cart_item]

  def index
    session[:cart_total] = 0
    @items = []
    if user_signed_in?
      @items = Cart.find_by(user_id: current_user.id).items
      @items.each do |item|
        session[:cart_total] =
          session[:cart_total] + item.item_price * CartItem.find_by(cart_id: current_user.cart.id,
                                                                    item_id: item.id).quantity
      end
    elsif session[:cart].present?
      session[:cart].each_key do |item_id|
        item = Item.find(item_id)
        @items << item
        session[:cart_total] = session[:cart_total] + item.item_price * session[:cart][item.id].to_i
      end
    end
  end

  def increase_quantity
    if user_signed_in?
      cart_item = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id)
      cart_item.quantity = cart_item.quantity + 1
      cart_item.save
    else
      session[:cart][params[:id]] = session[:cart][params[:id]].to_i + 1
    end
    @item = Item.find(params[:id])
    @item_quantity = get_item_quantity
    session[:cart_total] += Item.find(params[:id]).item_price
    respond_to do |format|
      format.js
    end
  end

  def decrease_quantity
    if user_signed_in?
      cart_item = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id)
      if cart_item.quantity == 1
        flash[:notice] = 'Quantity cannot be less than 1!'
      else
        cart_item.quantity = cart_item.quantity - 1
        cart_item.save
        session[:cart_total] -= Item.find(params[:id]).item_price
      end
    elsif session[:cart][params[:id]].to_i == 1
      flash[:notice] = 'Quantity cannot be less than 1!'
    else
      session[:cart][params[:id]] = session[:cart][params[:id]].to_i - 1
      session[:cart_total] -= Item.find(params[:id]).item_price
    end
    @item = Item.find(params[:id])
    @item_quantity = get_item_quantity
    respond_to do |format|
      format.js
    end
  end

  def cart_checkout
    if user_signed_in?
      if current_user.cart.items.empty?
        flash[:notice] = 'Cannot checkout with an empty cart!'
        redirect_to carts_path and return
      end

      items = current_user.cart.items
      total = 0
      items.each do |item|
        total += item.item_price * CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity
      end
      order = Order.create(user_id: current_user.id, status: 0, total: total)
      items.each do |item|
        OrderItem.create(item_id: item.id, order_id: order.id,
                         quantity: CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity)
      end
      CartItem.where(cart_id: current_user.cart.id).destroy_all
      redirect_to order_path(order)
    else
      flash[:notice] = 'Please Sign in before checking out!'
      redirect_to new_user_session_path
    end
  end

  def remove_cart_item
    if user_signed_in?
      CartItem.find_by!(cart_id: current_user.cart.id, item_id: params[:id]).destroy
    else
      session[:cart].delete(params[:id])
    end
    @removed_item_id = params[:id]
    flash[:notice] = 'Item removed from cart'
    calc_cart_total
    respond_to  do |format|
      format.js
    end
  end

  private

    def calc_cart_total
      session[:cart_total] = 0
      if user_signed_in?
        @items = Cart.find_by(user_id: current_user.id).items
        @items.each do |item|
          session[:cart_total] =
            session[:cart_total] + item.item_price * CartItem.find_by(cart_id: current_user.cart.id,
                                                                      item_id: item.id).quantity
        end
      elsif session[:cart].present?
        session[:cart].each_key do |item_id|
          item = Item.find(item_id)
          session[:cart_total] = session[:cart_total] + item.item_price * session[:cart][item.id].to_i
        end
      end
    end

    def get_item_quantity
      if user_signed_in?
        item_quantity = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id).quantity
      else
        item_quantity = session[:cart][params[:id].to_s]
      end
    end
end
