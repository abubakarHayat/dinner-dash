# frozen_string_literal: true

module CartsHelper
  def items_authenticated
    return unless user_signed_in?

    items = Cart.find_by(user_id: current_user.id).items
    items.each do |item|
      session[:cart_total] += item.item_price * CartItem.find_by(cart_id: current_user.cart.id,
                                                                 item_id: item.id).quantity
    end
    items
  end

  def items_unauthenticated
    return if session[:cart].nil?

    items = []
    session[:cart].each_key do |item_id|
      item = Item.find(item_id)
      items << item
      session[:cart_total] += item.item_price * session[:cart][item_id].to_i
    end
    items
  end

  def handle_quantity_dec_authenticated
    cart_item = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id)
    return if check_for_quantity(cart_item)

    cart_item.quantity -= 1
    cart_item.save
    session[:cart_total] -= Item.find(params[:id]).item_price
  end

  def handle_quantity_dec_unauthenticated
    return if check_for_quantity

    session[:cart][params[:id]] -= 1
    session[:cart_total] -= Item.find(params[:id]).item_price
  end

  def handle_quantity_inc_authenticated
    cart_item = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id)
    cart_item.quantity = cart_item.quantity + 1
    cart_item.save
    session[:cart_total] += Item.find(params[:id]).item_price
  end

  def handle_quantity_inc_unauthenticated
    session[:cart][params[:id]] += 1
    session[:cart_total] += Item.find(params[:id]).item_price
  end

  def check_for_quantity(cart_item = nil)
    if user_signed_in?
      flash[:notice] = 'Quantity cannot be less than 1!' if cart_item.quantity == 1
      cart_item.quantity == 1
    elsif session[:cart][params[:id]] == 1
      flash[:notice] = 'Quantity cannot be less than 1!'
      true
    end
  end

  def cart_total
    total = 0
    items = current_user.cart.items
    items.each do |item|
      total += item.item_price * CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity
    end
    total
  end

  def create_orders(order)
    items = current_user.cart.items
    items.each do |item|
      OrderItem.create(item_id: item.id, order_id: order.id,
                       quantity: CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity)
    end
  end

  def check_user_cart_checkout
    if !user_signed_in?
      flash[:notice] = 'Please Sign in before checking out!'
      redirect_to new_user_session_path
      false
    elsif current_user.cart.items.empty?
      flash[:notice] = 'Cannot checkout with an empty cart!'
      redirect_to carts_path
      false
    else
      true
    end
  end

  def manage_for_cart_dec
    quantity = if user_signed_in?
                 cart_item = CartItem.find_by!(cart_id: current_user.cart.id, item_id: params[:id])
                 cart_item.quantity
               else
                 session[:cart][params[:id]]
               end
    cart_total_dec(params[:id], quantity)
  end

  def remove_cart_item_for_users
    manage_for_cart_dec
    if user_signed_in?
      CartItem.find_by!(cart_id: current_user.cart.id, item_id: params[:id]).destroy
    else
      session[:cart].delete(params[:id])
    end
  end

  def cart_total_dec(item_id, quantity)
    session[:cart_total] -= Item.find(item_id).item_price * quantity
  end
end
