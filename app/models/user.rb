class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages

  has_many :splits, dependent: :destroy
  has_many :contacts, ->(user) { where.not(id: user.member_id).distinct }, through: :splits, source: :members

  belongs_to :member

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
