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
    case params[:status]
    when "ordered"
      @orders = Order.where(user_id: User.where(is_admin: false).pluck(:id), status: params[:status])
    when "paid"
      @orders = Order.where(user_id: User.where(is_admin: false).pluck(:id), status: params[:status])
    when "completed"
      @orders = Order.where(user_id: User.where(is_admin: false).pluck(:id), status: params[:status])
    when "cancelled"
      @orders = Order.where(user_id: User.where(is_admin: false).pluck(:id), status: params[:status])
    else
      @orders = Order.where(user_id: User.where(is_admin: false).pluck(:id))
    end
    authorize @orders
    @total_orders_by_status = Order.group(:status).count
  end

  private

    def order_params
      params.require(:order).permit(:status)
    end

end
