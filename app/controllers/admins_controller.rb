# frozen_string_literal: true

class AdminsController < ApplicationController
  def index
    @user = current_user
    authorize User
  end

  def show_categories
    @categories = Category.all
    authorize User
  end

  def show_items
    @items = Item.includes(:restaurant)
    authorize User
  end

  def show_orders
    @orders = if params[:status] != 'all'
                Order.where(user_id: User.where(role: 0).pluck(:id), status: params[:status])
              else
                Order.where(user_id: User.where(role: 0).pluck(:id))
              end
    authorize User
    @total_orders_by_status = Order.group(:status).count
  end

  def show_restaurants
    @restaurants = Restaurant.all
    authorize User
  end
end
