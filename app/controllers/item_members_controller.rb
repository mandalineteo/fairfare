class ItemMembersController < ApplicationController
  def new
    @item_member = ItemMember.new
  end

  def create()
    # filtered_item_members = Item_member.where(member_id: params[:member_id], bill_id: params[:bill_id], item_id: params[:id])
    # @item_member.bill_id = params[:bill_id]
    # @item_member.split_id = params[:split_id]

    @item_member = ItemMember.new
    @item_member.member_id = params[:member_id]
    @item_member.item_id = params[:item_id]

    if @item_member.save
      BillRoomChannel.broadcast_to(
        @item_member.item.bill,
        "HELLO"
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
    redirect_to split_bill_items_path, status: :see_other
  end
end
