class VenueTypeToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_reference :spaces, :type, null: false, foreign_key: true
  end
end
