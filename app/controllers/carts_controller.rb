# frozen_string_literal: true

class CartsController < ApplicationController
  include CurrentCart
  include CartsHelper
  before_action :set_cart
  before_action :adjust_quantity, only: [:increase_quantity]

  def index
    session[:cart_total] = 0
    @items = if user_signed_in?
               items_authenticated
             else
               items_unauthenticated
             end
  end

  def increase_quantity
    @item = Item.find(params[:id])
    @item_quantity = item_quantity
    respond_to do |format|
      format.js
    end
  end

  def decrease_quantity
    if user_signed_in?
      handle_quantity_dec_authenticated
    else
      handle_quantity_dec_unauthenticated
    end
    @item = Item.find(params[:id])
    @item_quantity = item_quantity
    respond_to do |format|
      format.js
    end
  end

  def checkout
    return unless check_user_cart_checkout

    total = cart_total
    order = Order.create(user_id: current_user.id, status: 0, total: total)
    create_orders(order)
    CartItem.where(cart_id: current_user.cart.id).destroy_all
    redirect_to order_path(order)
  end

  def remove_cart_item
    remove_cart_item_for_users
    @removed_item_id = params[:id]
    flash[:notice] = 'Item removed from cart'
    respond_to do |format|
      format.js
    end
  end

  private

  def adjust_quantity
    if user_signed_in?
      handle_quantity_inc_authenticated
    else
      handle_quantity_inc_unauthenticated
    end
  end

  def item_quantity
    if user_signed_in?
      CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id).quantity
    else
      session[:cart][params[:id].to_s]
    end
  end
end
