class Restaurant < ApplicationRecord
  has_many :items, dependent: :destroy
end
