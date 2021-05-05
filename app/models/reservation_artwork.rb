# frozen_string_literal: true

class ReservationArtwork < ApplicationRecord
  belongs_to :reservation
  belongs_to :artwork
end
