# frozen_string_literal: true

class RemoveColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :artworks, :subject,   :string
    remove_column :artworks, :styles,    :string
    remove_column :spaces,   :venue_type, :string
  end
end
