class Payer < ApplicationRecord
  belongs_to :bill
  belongs_to :member
end
