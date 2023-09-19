class Split < ApplicationRecord
  belongs_to :user

  has_many :split_members, dependent: :destroy
  has_many :members, through: :split_members
  has_many :bills, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true
  validates :status, presence: true

  def generate_split_data
    split_data = []
    self.bills.each do |bill|
      bill.items.each do |item|
        cost_per_payee = (item.quantity * item.price) / item.members.length
        item.members.each do |member|
          bill.members.each do |payer|
            split_data << {
              bill:,
              item:,
              payee_member: member,
              payer_member: payer,
              cost: cost_per_payee/bill.members.length
            }
          end
        end
      end
    end
    split_data
  end

  def get_split_stats
    payment_data = []
    self.members.each do |member1|
      self.members.each do |member2|
        if member1.id != member2.id
          payment_data << {
            payee_member: member1,
            payer_member: member2,
            amount: 0
          }
        end
      end
    end

    self.generate_split_data.each do |data|
      puts data
      payment_data.each do |data2|
        if data[:payee_member].id == data2[:payee_member].id && data[:payer_member].id == data2[:payer_member].id
          data2[:amount] = data2[:amount] + data[:cost]
        end
      end
    end

    payment_data.each do |data|
      payment_data.each do |data2|
        if data[:payee_member].id == data2[:payer_member].id && data[:payer_member].id == data2[:payee_member].id
          if data[:amount] > data2[:amount]
            data[:amount] = data[:amount] - data2[:amount]
            data2[:amount] = 0
          else
            data2[:amount] = data2[:amount] - data[:amount]
            data[:amount] = 0
          end
        end
      end
    end

    filled_data = payment_data.filter do |data|
      data[:amount].positive?
    end

    filled_data.each do |data|
      puts "#{data[:payee_member].id} owes #{data[:payer_member].id} SGD #{data[:amount]}"
    end

    return filled_data
  end
end
