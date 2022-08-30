# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update]

  def index
    @orders = current_user.orders
  end

  def show; end

  def edit
    authorize @order
  end

  def update
    authorize @order

    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def admin_show_orders
    @orders = if params[:status]
                Order.where(user_id: User.where(is_admin: false).pluck(:id), status: params[:status])
              else
                Order.where(user_id: User.where(is_admin: false).pluck(:id))
              end
    authorize @orders
    @total_orders_by_status = Order.group(:status).count
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
