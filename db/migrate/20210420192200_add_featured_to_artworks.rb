# frozen_string_literal: true

class AddFeaturedToArtworks < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :featured, :boolean, default: false
  end
end
