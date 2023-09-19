class AddServiceChargeAndDiscountToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :discount, :integer
    add_column :bills, :service_charge, :integer
  end
end
