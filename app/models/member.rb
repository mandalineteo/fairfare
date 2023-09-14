class Member < ApplicationRecord
  has_one :user, dependent: :destroy
  has_many :split_members
  has_many :payers
  has_many :item_members

  def registered?
    !user.nil?
  end
end
