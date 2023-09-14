class Member < ApplicationRecord
  has_many :users
  has_many :split_members
  has_many :payers
  has_many :item_members
end
