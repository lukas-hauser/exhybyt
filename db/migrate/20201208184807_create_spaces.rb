class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :venue_type
      t.string :category
      t.string :listing_name
      t.text :description
      t.string :address
      t.float :wall_height
      t.float :wall_width
      t.float :price
      t.boolean :is_adj_light
      t.boolean :is_nat_light
      t.boolean :is_dis_acc
      t.boolean :is_parking
      t.boolean :is_hang_sys
      t.boolean :is_plugs
      t.boolean :is_sec_sys
      t.boolean :is_toilet
      t.boolean :is_wifi
      t.boolean :is_storage
      t.boolean :is_paintings
      t.boolean :is_photography
      t.boolean :is_drawings
      t.boolean :is_sculptures
      t.boolean :is_live_perf
      t.boolean :is_adverts
      t.boolean :active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :spaces, [:user_id, :created_at]
  end
end
