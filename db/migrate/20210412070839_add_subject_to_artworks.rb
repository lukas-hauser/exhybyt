# frozen_string_literal: true

class AddSubjectToArtworks < ActiveRecord::Migration[6.1]
  def change
    add_reference :artworks, :subject, null: false, foreign_key: true
  end
end
