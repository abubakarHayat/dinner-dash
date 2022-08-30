# frozen_string_literal: true

class AddRestaurantToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :restaurant, foreign_key: true
  end
end
