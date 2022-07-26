module CurrentCart
  private

  # def set_cart
  #   if session[:cart_id].nil?
  #     @cart = Cart.create!
  #     session[:cart_id] = @cart.id
  #   else
  #     @cart = Cart.find(session[:cart_id])
  #   end
  # end

  # def set_cart
  #   if user_signed_in?
  #     begin
  #       @cart = Cart.find_by!(user_id: current_user.id)
  #       unless session[:cart_items].nil? || session[:cart_items].empty?
  #         session[:cart_items].each {|item_id| @cart.items << Item.find(item_id.to_i)}
  #       end
  #       @cart_items = @cart.items.pluck(:id)
  #     rescue ActiveRecord::RecordNotFound
  #       @cart = Cart.create({user_id: current_user.id})
  #       @cart_items = []
  #     end
  #   else
  #     session[:cart_items] ||= []
  #   end
  # end

  # def set_cart
  #   unless session[:cart_items].nil? || session[:cart_items].empty?

  #   else
  #     session[:cart_items] ||= []
  #   end
  # end

  def set_cart
    if user_signed_in?
      begin
       @cart = Cart.find_by!(user_id: current_user.id)
      rescue ActiveRecord::RecordNotFound
        @cart = Cart.create!({user_id: current_user.id})
      ensure
        unless session[:cart_items].nil? || session[:cart_items].empty?
          session[:cart_items].each {|item_id| @cart.items << Item.find(item_id)}
          session[:cart_items] = []
        else
          session[:cart_items] ||= []
        end
      end
    end
  end

end
