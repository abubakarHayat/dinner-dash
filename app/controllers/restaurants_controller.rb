class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to @restaurant
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @restaurant_items = Item.joins(:restaurant).where("restaurants.id = ?", params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    redirect_to root_path, status: :see_other
  end

  def admin_show_restaurants
    @restaurant = Restaurant.all
  end

  private
    def restaurant_params
      params.require(:restaurant_name).permit(:restaurant_name)
    end
end
