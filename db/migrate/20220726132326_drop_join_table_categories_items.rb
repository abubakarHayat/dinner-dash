class DropJoinTableCategoriesItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :categories_items
  end
end
