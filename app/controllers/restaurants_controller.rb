# frozen_string_literal: true

class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize @restaurant

    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @restaurant_items = Item.where(restaurant_id: params[:id], is_sold: true)
    authorize Restaurant
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @restaurant.destroy

    flash[:alert] = 'Restaurant deleted!'
    redirect_to show_restaurants_admins_path, status: :see_other
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:restaurant_name)
  end
end
