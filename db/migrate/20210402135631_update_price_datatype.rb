# frozen_string_literal: true

class UpdatePriceDatatype < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :artworks do |t|
        dir.up   { t.change :price, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :price, :float }
      end

      change_table :spaces do |t|
        dir.up   { t.change :price, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :price, :float }
      end

      change_table :reservations do |t|
        dir.up   { t.change :price, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :price, :float }
        dir.up   { t.change :total, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :total, :float }
      end

      change_table :orders do |t|
        dir.up   { t.change :price, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :price, :integer }
        dir.up   { t.change :delivery_fee, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :delivery_fee, :integer }
        dir.up   { t.change :total, :decimal, precision: 8, scale: 2 }
        dir.down { t.change :total, :integer }
      end
    end
  end
end
