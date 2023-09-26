class PayersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @payer = Payer.new
  end

  def create
    # filtered_payers = Payer.where(member_id: params[:member_id], bill_id: params[:bill_id])
    # if filtered_payers.length > 0
    #   filtered_payers.destroy_all
    # else

    @member = Member.find(params[:member_id])
    @bill = Bill.find(params[:bill_id])
    @payer = Payer.new
    @payer.member = @member
    @payer.bill = @bill

    respond_to do |format|
      if @payer.save
        # broadcast here
        PayerPillsChannel.broadcast_to(
          @bill,
          {
            hello: 'hi'
            # member_id: @item_member.member.id,
            # item_id: @item_member.item.id,
            # item_member_list: render_to_string(
            #   partial: "items/added_item_members",
            #   locals: {
            #     item: @item_member.item
            #   },
            #   formats: [:html]
            # ),
            # item_member_form_html: render_to_string(
            #   partial: "items/item_member",
            #   locals: {
            #     member: @item_member.member,
            #     bill: @item_member.item.bill,
            #     split: @item_member.item.bill.split,
            #     item: @item_member.item,
            #     item_member: @item_member
            #   },
            #   formats: [:html]
            # )
          }
        )
        ####
        format.html { redirect_to split_bill_items_path}
        format.json { render 'payer_partial' }
      else
        format.html { render "items/index", status: :unprocessible_entity }
        format.json { render json: { status: 402 } }
      end
    end

    # end
  end

  def destroy
    @payer = Payer.find(params[:id])
    @payer.destroy

    @split = Split.find(params[:split_id])
    @bill = Bill.find(params[:bill_id])
    @member = @payer.member

    respond_to do |format|
      format.html { redirect_to split_bill_items_path(@split, @bill), status: :see_other }
      format.json { render 'payer_partial' }
    end
  end
end
