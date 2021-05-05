# frozen_string_literal: true

class AddDisplaynameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :display_name, :string
  end
end
