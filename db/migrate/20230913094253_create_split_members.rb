class CreateSplitMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :split_members do |t|
      t.references :split, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
