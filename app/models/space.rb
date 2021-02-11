class Space < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :reservations, dependent: :destroy

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :listing_name, presence: true, length: { maximum: 60 }
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category, presence: true
  validates :venue_type, presence: true
  validates :wall_height, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :wall_width, presence: true, numericality: {only_float: true, :greater_than => 0}
  validates :price, presence: true, numericality: {only_float: true, :greater_than => 0}

  validates :images, #presence: true,
                    content_type: { in: %w[image/jpeg image/jpg image/gif image/png], message: "Please upload a valid file type (jpeg, gif, png)." },
                    size: { less_than: 5.megabytes, message: "exceeds 5MB." }

#  def display_image
#    image.variant(resize_to_limit: [500,500])
#  end
end
