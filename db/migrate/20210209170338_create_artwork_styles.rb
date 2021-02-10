class CreateArtworkStyles < ActiveRecord::Migration[6.1]
  def change
    create_table :artwork_styles do |t|
      t.integer :artwork_id
      t.integer :style_id

      t.timestamps
    end
  end
end
