class Split < ApplicationRecord
  belongs_to :user

  has_many :split_members
  has_many :bills
end
