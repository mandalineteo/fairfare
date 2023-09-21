class SplitMember < ApplicationRecord
  belongs_to :split
  belongs_to :member

  validates :member_id, uniqueness: { scope: :split }, presence: true
  validates :split_id, presence: true
end
