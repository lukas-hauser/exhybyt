class AddFreeToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :for_free, :boolean, default: false
  end
end
