class Item < ApplicationRecord
  belongs_to :bill

  has_many :item_members
end
