class CreateSplits < ActiveRecord::Migration[7.0]
  def change
    create_table :splits do |t|
      t.string :status
      t.string :name
      t.date :date
      t.string :invite_code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
