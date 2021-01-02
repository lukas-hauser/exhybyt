class Artwork < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :user_id, presence: true
  validates :listing_name, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category, presence: true
  validates :year, presence: true, numericality: {only_integer: true}
  validates :medium, presence: true, length: { maximum: 60 }
  validates :status, presence: true
  validates :subject, presence: true
  validates :styles, presence: true

  validates :height, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :width, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :depth, numericality: {only_float: true, :greater_than => 0}
  validates :price, presence: true, numericality: {only_float: true, :greater_than => 0}

  validates :images, #presence: true,
                    content_type: { in: %w[image/jpeg image/jpg image/gif image/png], message: "Please upload a valid file type (jpeg, gif, png)." },
                    size: { less_than: 5.megabytes, message: "exceeds 5MB." }
end
