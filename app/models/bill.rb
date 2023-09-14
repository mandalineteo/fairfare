class Bill < ApplicationRecord
  belongs_to :split

  has_many :payers
  has_many :items
end
