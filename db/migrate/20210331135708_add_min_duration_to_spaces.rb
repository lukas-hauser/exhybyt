class AddMinDurationToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :days_min, :integer
  end
end
