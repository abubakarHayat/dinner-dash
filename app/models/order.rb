class Order < ApplicationRecord
  enum status: {
    ordered: 0,
    paid: 1,
    cancelled: 2,
    completed: 3
  }
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :status, inclusion: { in: statuses.keys }
end
