class AddQuantityToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :quantity, :integer
    change_column_null :cart_items, :quantity, false
  end
end
