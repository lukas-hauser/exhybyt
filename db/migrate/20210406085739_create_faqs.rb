# frozen_string_literal: true

class CreateFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :faqs do |t|
      t.string :question
      t.text :answer
      t.string :category

      t.timestamps
    end
    add_index :faqs, :category
  end
end
