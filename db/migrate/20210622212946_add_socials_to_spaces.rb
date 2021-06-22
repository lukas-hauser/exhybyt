class AddSocialsToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :instagram, :string
    add_column :spaces, :facebook, :string
    add_column :spaces, :website, :string
    add_column :spaces, :twitter, :string
  end
end
