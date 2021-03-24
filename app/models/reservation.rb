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

  default_scope -> { order(created_at: :desc) }

  # Approves a reservation
  def approve
    update_columns(approved: true, approved_at: Time.zone.now,
                   rejected: false)
  end

  # Rejects a reservation
  def reject
    update_columns(rejected: true, rejected_at: Time.zone.now,
                   approved: false)
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
