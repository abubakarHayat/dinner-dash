module CurrentCart
  private

  def set_cart
    if user_signed_in?
      begin
       @cart = Cart.find_by!(user_id: current_user.id)
      rescue ActiveRecord::RecordNotFound
        @cart = Cart.create!({user_id: current_user.id})
      ensure
        unless session[:cart].nil? || session[:cart].empty?
          session[:cart].keys.each do |item_id|
            cart_item = CartItem.find_by(cart_id: @cart.id, item_id: item_id)
            if cart_item.nil?
              CartItem.create(cart_id: @cart.id, item_id:item_id, quantity: session[:cart][item_id])
            else
              cart_item.quantity = session[:cart][item_id] + cart_item.quantity
              cart_item.save
            end
          end
          session[:cart] = {}
        else
          session[:cart] ||= {}
        end
      end
    end
    # session[:cart] ||= {}
  end

end
