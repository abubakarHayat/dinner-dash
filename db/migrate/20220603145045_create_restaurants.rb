class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name

      t.timestamps
    end
  end
end
