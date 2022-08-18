class DropJoinTableCartsItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :carts_items
  end
end
