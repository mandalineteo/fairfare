class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :member

  validates :nickname, presence: true

  def phone_number
    member.phone_number
  end
end
