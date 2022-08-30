class ChangeNullColumnItemTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :item_title, false
    change_column_null :items, :item_description, false
    change_column_null :items, :item_price, false
  end
end
