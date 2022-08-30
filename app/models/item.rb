# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  belongs_to :restaurant
  has_one_attached :image, dependent: :destroy

  validates :item_title, :item_description, :item_price, presence: true
  validates :category_ids, presence: true
  validate :check_image_type

  scope :sold_items, -> { where(is_sold: true) }

  private

  def check_image_type
    return unless image.attached? && !image.content_type.in?(%w[image/jpeg image/png])

    errors.add(:image, 'Image must be a JPEG or PNG!')
  end
end
