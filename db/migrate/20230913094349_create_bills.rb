class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.string :merchant
      t.references :split, null: false, foreign_key: true

      t.timestamps
    end
  end
end
