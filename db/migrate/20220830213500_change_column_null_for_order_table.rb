class ChangeColumnNullForOrderTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :orders, :status, false
    change_column_null :orders, :total, false
  end
end
