# frozen_string_literal: true

module CurrentCart
  private

  def set_cart
    return unless user_signed_in?

    begin
      @cart = Cart.find_by!(user_id: current_user.id)
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create!({ user_id: current_user.id })
    ensure
      create_cart
    end
  end

  def create_cart
    if session[:cart].blank?
      session[:cart] ||= {}
    else
      create_cart_items
      session[:cart] = {}
    end
  end

  def create_cart_items
    session[:cart].each_key do |item_id|
      create_each_cart_item(item_id)
    end
  end

  def create_each_cart_item(item_id)
    cart_item = CartItem.find_by(cart_id: @cart.id, item_id: item_id)
    if cart_item.nil?
      CartItem.create(cart_id: @cart.id, item_id: item_id, quantity: session[:cart][item_id])
    else
      cart_item.quantity = session[:cart][item_id] + cart_item.quantity
      cart_item.save
    end
  end

end
