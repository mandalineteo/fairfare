class Member < ApplicationRecord
  has_one :user, dependent: :destroy
  has_many :split_members
  has_many :splits, through: :split_members
  has_many :payers
  has_many :item_members
  has_many :items, through: :item_members

  validates :phone_number, presence: true, uniqueness: true

  def registered?
    !user.nil?
  end

  def given_nickname(current_user)
    contact = Contact.find_by(
      member: self,
      user: current_user
    )
    contact ? contact.nickname : 'No nickname???'
  end

  def payer?(bill)
    payer = Payer.find_by(
      member: self,
      bill:
    )
    puts '-------------------'
    puts payer ? true : false
    return payer ? true : false
    # code method to find out if member has payer for bill
  end
end
