# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :space
  belongs_to :user
  belongs_to :reservation

  validates :star, presence: true, numericality: { only_integer: true,
                                                   greater_than_or_equal_to: 1,
                                                   less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { maximum: 1000 }
  default_scope -> { order(created_at: :desc) }

  def review_time
    created_at.strftime('%d %b %Y')
  end
end
