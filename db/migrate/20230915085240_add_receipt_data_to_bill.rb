class AddReceiptDataToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :receipt_data, :jsonb
  end
end
