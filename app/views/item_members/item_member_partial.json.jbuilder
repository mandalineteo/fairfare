json.item_member_html render(
  partial: 'items/item_member',
  formats: :html,
  locals: {
    member: @member,
      split: @bill.split,
      bill: @bill,
      item: item,
      item_member: ItemMember.new
  }
)
