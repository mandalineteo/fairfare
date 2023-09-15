class Member < ApplicationRecord
  has_one :user, dependent: :destroy
  has_many :split_members
  has_many :payers
  has_many :item_members

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  def registered?
    !user.nil?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
