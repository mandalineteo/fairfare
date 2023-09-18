class RemoveDetailsFromMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :first_name, :string
    remove_column :members, :last_name, :string
  end
end
