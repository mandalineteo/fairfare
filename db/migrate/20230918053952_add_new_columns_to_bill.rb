class AddNewColumnsToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :date, :date
    add_column :bills, :taxes, :integer
    add_column :bills, :total_amount, :integer
  end
end
