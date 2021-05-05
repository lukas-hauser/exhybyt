# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :artwork, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :delivery_method
      t.integer :delivery_fee, default: 0
      t.integer :price
      t.integer :total
      t.string :checkout_session_id
      t.boolean :payment_completed, default: false
      t.string :status

      t.timestamps
    end
  end
end
