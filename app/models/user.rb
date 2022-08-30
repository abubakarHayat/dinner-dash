# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :display_name, length: { in: 2...32 }, unless: -> { display_name.blank? }

  def admin?
    role == 1
  end
end
