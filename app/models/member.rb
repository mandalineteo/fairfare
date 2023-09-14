class Member < ApplicationRecord
  has_one :user
  has_many :split_members
  has_many :payers
  has_many :item_members
end
