class Split < ApplicationRecord
  belongs_to :user

  has_many :split_members, dependent: :destroy
  has_many :members, through: :split_members
  has_many :bills, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true
  validates :status, presence: true



  def split_stats
    split_settlements = []

    bills.each do |bill|
      bill.settlement.each do |settlement|
        # settlement : {total:, member:}
        member_settlement = split_settlements.find { |hash| hash[:member] == settlement[:member] }
        # check if SS has this member
        if member_settlement
          # add to the total
          member_settlement[:total] += settlement[:total]
        else
          # create a new item
          split_settlements << settlement
        end
      end
    end

    return split_settlements
  end


end
