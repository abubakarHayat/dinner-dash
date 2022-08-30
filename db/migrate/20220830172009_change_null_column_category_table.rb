class ChangeNullColumnCategoryTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :categories, :category_name, false
  end
end
