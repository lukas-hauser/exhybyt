# frozen_string_literal: true

class ArtworkStyle < ApplicationRecord
  belongs_to :artwork
  belongs_to :style
end
