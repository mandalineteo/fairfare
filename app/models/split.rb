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
          member_settlement[:amount] += settlement[:amount]
        else
          # create a new item
          split_settlements << settlement
        end
      end
    end

    return split_settlements
  end

  def sort_split_stats
    {
      payers: split_stats.select { |stat| stat[:amount].negative? }.sort_by { |payer| payer[:amount] },
      payees: split_stats.select { |stat| stat[:amount].positive? }.sort_by { |payee| payee[:amount] }.reverse
    }
  end

  def settlements
    sort_split_hash = sort_split_stats
    # raise
    # outstanding_payer = sort_split_stats[:payers][0][:member][:phone_number]
    # outstanding_payer_amount = sort_split_stats[:payers][0][:amount]

    # payee = sort_split_stats[:payees][0][:member][:phone_number]
    # payee_amount = sort_split_stats[:payees][0][:amount]

    settlements = []

    sort_split_hash[:payers].each do |payer|
      sort_split_hash[:payees].each do |payee|
        diff = payer[:amount] + payee[:amount]

        amount = 0
        if !diff.positive?
          amount = payee[:amount].abs.to_i
          payee[:amount] = 0
          payer[:amount] = diff

        else
          amount = payer[:amount].abs.to_i
          payee[:amount] = diff
          payer[:amount] = 0
        end
        settlements << {
          payee: payee[:member],
          payer: payer[:member],
          amount:
        } if amount.positive?
      end
    end
    settlements

  end
end
