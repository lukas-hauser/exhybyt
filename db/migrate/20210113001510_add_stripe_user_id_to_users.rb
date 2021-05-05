# frozen_string_literal: true

class AddStripeUserIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stripe_user_id, :string
  end
end
