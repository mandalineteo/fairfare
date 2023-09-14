class Item < ApplicationRecord
  belongs_to :bill

  has_many :item_members
  has_many :items, through: :item_members
end
