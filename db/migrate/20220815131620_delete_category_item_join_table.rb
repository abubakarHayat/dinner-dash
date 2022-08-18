class DeleteCategoryItemJoinTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :category_items
  end
end
