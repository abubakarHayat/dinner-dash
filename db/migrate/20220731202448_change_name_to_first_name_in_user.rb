# frozen_string_literal: true

class ChangeNameToFirstNameInUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :name, :first_name
  end
end
