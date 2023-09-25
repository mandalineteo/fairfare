class Bill < ApplicationRecord
  include CurrencyConversion

  # TODO: implement a concern

  currency_attr :total_amount
  currency_attr :taxes
  currency_attr :service_charge
  currency_attr :discount

  belongs_to :split

  # has_many :bill_members, dependent: :destroy
  # has_many :payers, through: :bill_members, class_name: 'Member'

  attribute :discount, default: 0
  attribute :taxes, default: 0
  attribute :service_charge, default: 0

  has_many :payers, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :item_members, through: :items
  has_many :members, through: :item_members
  # has_many :all_members, through: :item_members, source: 'Member'
  has_one_attached :photo

  # added by cl (15-09)
  accepts_nested_attributes_for :items, reject_if: proc { |attributes| attributes.values.any?(&:blank?) }, allow_destroy: true

  def all_split_members
    split.members
  end

  def update_total_bill
    total_sum = 0

    items.each do |item|
      total_sum += item.quantity * item.price
    end

    pp "test"
    puts total_sum - discount + taxes + service_charge


    update(total_amount: total_sum - discount + taxes + service_charge)
  end

  def scraping_data
    photo.present? && receipt_data.nil?
  end

  def settlement
    all_split_members.uniq.map { |member| member.total_consumed(self) }
  end

  def even_split_tax
    return 0 if taxes.nil?

    (taxes + service_charge) / (all_split_members.uniq.count.positive? ? all_split_members.uniq.count : 1)
  end
end
