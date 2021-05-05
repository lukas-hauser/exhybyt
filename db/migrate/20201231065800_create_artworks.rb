# frozen_string_literal: true

class CreateArtworks < ActiveRecord::Migration[6.0]
  def change
    create_table :artworks do |t|
      t.string :listing_name
      t.text :description
      t.float :height
      t.float :width
      t.float :depth
      t.integer :year
      t.string :category
      t.string :medium
      t.float :price
      t.string :status
      t.boolean :is_framed, default: false
      t.string :subject
      t.string :styles
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
