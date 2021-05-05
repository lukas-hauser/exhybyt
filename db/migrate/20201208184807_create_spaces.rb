# frozen_string_literal: true

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
      t.boolean :is_adj_light, default: false
      t.boolean :is_nat_light, default: false
      t.boolean :is_dis_acc, default: false
      t.boolean :is_parking, default: false
      t.boolean :is_hang_sys, default: false
      t.boolean :is_plugs, default: false
      t.boolean :is_sec_sys, default: false
      t.boolean :is_toilet, default: false
      t.boolean :is_wifi, default: false
      t.boolean :is_storage, default: false
      t.boolean :is_paintings, default: false
      t.boolean :is_photography, default: false
      t.boolean :is_drawings, default: false
      t.boolean :is_sculptures, default: false
      t.boolean :is_live_perf, default: false
      t.boolean :is_adverts, default: false
      t.boolean :active, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :spaces, %i[user_id created_at]
  end
end
