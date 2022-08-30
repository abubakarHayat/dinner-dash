# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :restaurant_name, presence: true
end
