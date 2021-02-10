class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :space

  has_many :reservation_artworks
  has_many :artworks, through: :reservation_artworks

  validates :price, presence: true
  validates :total, presence: true
  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate  :end_date_after_start_date
  validates :artwork_ids, presence: true

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

end
