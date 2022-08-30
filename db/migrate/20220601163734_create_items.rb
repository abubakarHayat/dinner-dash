# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_title
      t.string :item_description
      t.integer :item_price

      t.timestamps
    end
  end
end
