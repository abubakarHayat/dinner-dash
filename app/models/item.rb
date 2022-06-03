class Item < ApplicationRecord
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :carts
  belongs_to :restaurant

end
