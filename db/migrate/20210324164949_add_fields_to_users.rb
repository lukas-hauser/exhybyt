# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :instagram, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :website, :string
    add_column :users, :bio, :text
    add_column :users, :currency, :string
    add_column :users, :user_name, :string
    add_column :users, :marketing_consent, :boolean, default: false
  end
end
