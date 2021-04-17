class Space < ApplicationRecord
  belongs_to :user
  belongs_to :type
  has_many_attached :images
  has_many :reservations, dependent: :destroy
  has_many :reviews

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  has_many :schedules
  accepts_nested_attributes_for :schedules, allow_destroy: true

  def open_weekends?
    schedules.exists?(weekday: [6,7])
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :type_id, presence: true
  validates :listing_name, presence: true, length: { maximum: 60 }
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category, presence: true
  validates :wall_height, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :wall_width, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :price, presence: true, numericality: {:greater_than_or_equal_to => 5}
  validates :days_min, presence: true, numericality: {only_integer: true, :greater_than_or_equal_to => 1}

  validates :images, presence: true,
                    content_type: { in: %w[image/jpeg image/jpg image/gif image/png], message: "Please upload a valid file type (jpeg, gif, png)." },
                    size: { less_than: 5.megabytes, message: "exceeds 5MB." }

#  def display_image
#    image.variant(resize_to_limit: [500,500])
#  end

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
