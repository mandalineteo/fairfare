class ItemMembersController < ApplicationController
  def new
    @item_member = ItemMember.new
  end

  def create
    # filtered_item_members = Item_member.where(member_id: params[:member_id], bill_id: params[:bill_id], item_id: params[:id])
    # @item_member.bill_id = params[:bill_id]
    # @item_member.split_id = params[:split_id]

    @item_member = ItemMember.new
    @item_member.member_id = params[:member_id]
    @item_member.item_id = params[:item_id]

    if @item_member.save
      BillRoomChannel.broadcast_to(
        @item_member.item.bill,
        {
          member_id: @item_member.member.id,
          item_id: @item_member.item.id,
          item_member_list: render_to_string(
            partial: "items/added_item_members",
            locals: {
              item: @item_member.item
            },
            formats: [:html]
          ),
          item_member_form_html: render_to_string(
            partial: "items/item_member",
            locals: {
              member: @item_member.member,
              bill: @item_member.item.bill,
              split: @item_member.item.bill.split,
              item: @item_member.item,
              item_member: @item_member
            },
            formats: [:html]
          )
        }
      )
    end

    head :ok

    # respond_to do |format|
    #   if @item_member.save
    #     format.html { redirect to split_bill_items_path }
    #     format.json { render 'item_member_partial' }
    #   else
    #     format.html { render "items/index", status: :unprocessible_entity }
    #     format.json { render json: { status: 402 } }
    #   end

    # end
  end

  def destroy
    @item_member = ItemMember.find(params[:id])
    @item_member.destroy

    BillRoomChannel.broadcast_to(
      @item_member.item.bill,
      {
        member_id: @item_member.member.id,
        item_id: @item_member.item.id,
        item_member_list: render_to_string(
          partial: "items/added_item_members",
          locals: {
            item: @item_member.item
          },
          formats: [:html]
        ),
        item_member_form_html: render_to_string(
          partial: "items/item_member",
          locals: {
            member: @item_member.member,
            bill: @item_member.item.bill,
            split: @item_member.item.bill.split,
            item: @item_member.item,
            item_member: @item_member
          },
          formats: [:html]
        )
      }
    )
  end
end
