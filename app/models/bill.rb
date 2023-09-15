class Bill < ApplicationRecord
  belongs_to :split

  # has_many :bill_members, dependent: :destroy
  # has_many :payers, through: :bill_members, class_name: 'Member'

  has_many :payers, dependent: :destroy
  has_many :members, through: :payers
  has_many :items, dependent: :destroy

  validates :merchant, presence: true
  # added by cl (15-09)
  accepts_nested_attributes_for :items
end

# @bill.paid_by => [<member>,<member>]
