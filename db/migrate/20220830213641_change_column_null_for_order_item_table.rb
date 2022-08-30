class ChangeColumnNullForOrderItemTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :order_items, :quantity, false
  end
end
