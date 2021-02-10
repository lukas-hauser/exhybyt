class Style < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  has_many :artwork_styles
  has_many :artworks, through: :artwork_styles
end
