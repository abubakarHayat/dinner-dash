class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @cart_items = []
    if user_signed_in?
      @cart_items = Cart.find_by(user_id: current_user.id).items
    else
      unless session[:cart_items].nil? || session[:cart_items].empty?
        session[:cart_items].each {|item_id| @cart_items << Item.find(item_id)}
      end
    end
  end

end
