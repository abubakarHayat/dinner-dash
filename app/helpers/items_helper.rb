module ItemsHelper

  def check_cartable_authenticated
    current_user.cart.items.first.restaurant_id == Item.find(params[:id]).restaurant_id
  end

  def check_cartable_unauthenticated
    item_id = session[:cart].keys[0]
    first_item = Item.where(id: item_id).pluck(:restaurant_id)
    current_item = Item.where(id: params[:id]).pluck(:restaurant_id)
    first_item == current_item
  end

  def make_cart_for_items
    session[:cart][params[:id]] = recieve_cart_value
    flash[:notice] = 'Item added to cart'
  end

  def recieve_cart_value
    if session[:cart][params[:id]].nil?
      1
    else
      session[:cart][params[:id]].to_i + 1
    end
  end
end
