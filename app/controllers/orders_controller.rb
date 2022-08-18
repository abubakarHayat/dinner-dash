class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
    authorize @order
  end

  def update
    @order = Order.find(params[:id])
    authorize @order

    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def admin_show_orders
    @orders = Order.where(user_id: User.where(is_admin: false).pluck(:id))
    authorize @orders
  end

  private

    def order_params
      params.require(:order).permit(:status)
    end

end
