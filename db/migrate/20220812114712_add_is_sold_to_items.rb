class AddIsSoldToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :is_sold, :boolean, default: true
  end
end
