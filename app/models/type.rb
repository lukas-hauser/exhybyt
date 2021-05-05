# frozen_string_literal: true

class Type < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :name, uniqueness: true

  has_many :spaces
end
