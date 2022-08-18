class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    session[:cart_total] = 0
    @items = []
    if user_signed_in?
      @items = Cart.find_by(user_id: current_user.id).items
      @items.each do |item|
        session[:cart_total] = session[:cart_total] + item.item_price * CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity
      end
    else
      unless session[:cart].nil? || session[:cart].empty?
        session[:cart].keys.each do |item_id|
          item = Item.find(item_id)
          @items << item
          session[:cart_total] = session[:cart_total] + item.item_price * session[:cart][item.id].to_i
        end
      end
    end
  end

end
