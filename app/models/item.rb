class Item < ApplicationRecord
  belongs_to :bill

  has_many :item_members
  has_many :items, through: :item_members

  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
