class Split < ApplicationRecord
  belongs_to :user

<<<<<<< HEAD
  has_many :split_members, dependent: :destroy
  has_many :members, through: :split_members
  has_many :bills, dependent: :destroy
=======
  has_many :split_members
  has_many :bills
>>>>>>> master
end
