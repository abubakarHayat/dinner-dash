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
      if session[:cart][params[:id]].nil?
        session[:cart][params[:id]] = 1
      else
        session[:cart][params[:id]] = session[:cart][params[:id]].to_i + 1
      end
      flash[:notice] = "Item added to cart"
    else
      flash[:notice] = "Item from 2 different restaurants cannot be added at the same time in the cart!"
    end
  end

  def remove_cart_item
    if user_signed_in?
      CartItem.find_by!(cart_id: current_user.cart.id, item_id: params[:id]).destroy
    else
      session[:cart].delete(params[:id])
    end
    flash[:notice] = "Item removed from cart"
  end

  def increase_quantity
    if user_signed_in?
      cart_item = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id)
      cart_item.quantity = cart_item.quantity + 1
      cart_item.save
    else
      session[:cart][params[:id]] = session[:cart][params[:id]].to_i + 1
    end

  end

  def decrease_quantity
    if user_signed_in?
      cart_item = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id)
      if cart_item.quantity == 1
        flash[:notice] = "Quantity cannot be less than 1!"
      else
        cart_item.quantity = cart_item.quantity - 1
        cart_item.save
      end
    else
      if session[:cart][params[:id]].to_i == 1
        flash[:notice] = "Quantity cannot be less than 1!"
      else
        session[:cart][params[:id]] = session[:cart][params[:id]].to_i - 1
      end
    end
  end

  # def get_item_quantity
  #   if user_signed_in?
  #     @item_ quantity = CartItem.find_by(item_id: params[:id], cart_id: current_user.cart.id).quantity
  #   else
  #     @item_quantity = session[:cart][params[:id].to_s]
  #   end
  # end

  def cart_checkout
    if user_signed_in?
      if current_user.cart.items.empty?
        flash[:notice] = "Cannot checkout with an empty cart!"
        redirect_to carts_path and return
      end

      items = current_user.cart.items
      total = 0
      items.each do |item|
        total = total + item.item_price * CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity
      end
      order = Order.create(user_id: current_user.id, status: 0, total: total)
      items.each do |item|
        OrderItem.create(item_id: item.id, order_id: order.id, quantity: CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id).quantity)
      end
      CartItem.where(cart_id: current_user.cart.id).destroy_all
      redirect_to order_path(order)
    else
      flash[:notice] = "Please Sign in before checking out!"
      redirect_to new_user_session_path
    end
  end

  private
    def item_params
      params.require(:item).permit(:item_title, :item_description, :item_price, :restaurant_id, :image, :is_sold, category_ids: [])
    end

    def cartable?
      if user_signed_in? && !current_user.cart.items.first.nil?
        current_user.cart.items.first.restaurant_id ==  Item.find(params[:id]).restaurant_id

      else
        unless session[:cart].empty?
          item_id = session[:cart].keys[0]
          first_item = Item.where(id: item_id).pluck(:restaurant_id)
          current_item = Item.where(id: params[:id]).pluck(:restaurant_id)
          first_item == current_item
        else
          true
        end
      end
    end
end
