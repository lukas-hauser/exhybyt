class ReservationArtwork < ApplicationRecord
  belongs_to :reservation
  belongs_to :artwork
end
