class AddDefaultStatusToSplit < ActiveRecord::Migration[7.0]
  def change
    change_column :splits, :status, :string, default: "draft"
  end
end
