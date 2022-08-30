# frozen_string_literal: true

class ChangeNullColumnRestaurantTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :restaurants, :restaurant_name, false
  end
end
