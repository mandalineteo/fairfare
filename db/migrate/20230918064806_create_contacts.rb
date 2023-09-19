class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :nickname
      t.references :user, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
