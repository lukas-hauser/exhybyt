class Order < ApplicationRecord
  belongs_to :artwork
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :price, presence: true
  validates :delivery_fee, presence: true
  validates :total, presence: true
  validates :user_id, presence: true
end
