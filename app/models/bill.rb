class Bill < ApplicationRecord
  belongs_to :split

  # has_many :bill_members, dependent: :destroy
  # has_many :payers, through: :bill_members, class_name: 'Member'

  has_many :payers, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :item_members, through: :items
  has_many :members, through: :item_members
  # has_many :all_members, through: :item_members, source: 'Member'
  has_one_attached :photo

  # added by cl (15-09)
  accepts_nested_attributes_for :items

  def scraping_data
    photo.present? && receipt_data.nil?
  end

  # def members
  #   all_members.uniq
  # end

  def settlement
    members.uniq.map { |member| member.total_consumed(self) }
  end

  def even_split_tax
    taxes / members.uniq.count
  end

  def get_bill_stats
    # bills.map(&:settlement)
    payer_negative = []
    payee_positive = []
      # bill.uniq.members.each do |member|
      # bills.each do |bill|
      settlement.each do |settlement|

        if settlement[:total].positive?
          to_pay = {
            member: settlement[:member],
            amount: settlement[:total]
          }
          payee_positive << to_pay
        else
          payer = {
            member: settlement[:member],
            amount: settlement[:total]
          }
          payer_negative << payer
        end
      end
      return {
        payers: payer_negative.sort_by { |payer| payer[:amount] },
        payees: payee_positive.sort_by { |payee| payee[:amount] }.reverse
      }
      # end
  end

  def bill_calculations
    get_bill_stats

  end

  # @bill.paid_by => [<member>,<member>]
  # members.each do |member|
  #   amount_consumed = 0
  #   member.items each do |item|
  #     amount_consumed += item.quantity
  #   end
  #   member_consumption = {
  #     member: member.phone_number,
  #     amount_consumed:
  #   }
  #   amount << member_consumption
  # end
end
