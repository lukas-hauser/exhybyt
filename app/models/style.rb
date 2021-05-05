# frozen_string_literal: true

class Style < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :name, uniqueness: true

  has_many :artwork_styles
  has_many :artworks, through: :artwork_styles
end
