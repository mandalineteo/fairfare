class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages

  has_many :splits, dependent: :destroy

  belongs_to :member

  before_save :make_admin

  def make_admin
    self.admin = true
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
