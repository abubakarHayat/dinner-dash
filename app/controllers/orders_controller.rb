# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update]

  def index
    # @orders = current_user.orders
    @orders_all = Order.all
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

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
