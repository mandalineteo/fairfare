class Item < ApplicationRecord
  belongs_to :bill

  has_many :item_members
  has_many :members, through: :item_members
end
