class PayersController < ApplicationController
  def new
    @payer = Payer.new
  end

  def create()
    filtered_payers = Payer.where(member_id: params[:member_id], bill_id: params[:bill_id])

    if filtered_payers.length > 0
      filtered_payers.destroy_all

    else
      @payer = Payer.new
      @payer.member_id = params[:member_id]
      @payer.bill_id = params[:bill_id]

      respond_to do |format|
        if @payer.save
          puts "HOORAY"
          format.html { redirect to split_bill_items_path}
          format.json
        else
          format.html { render "items/index", status: :unprocessible_entity }
          format.json
        end
      end
    end
  end

  def destroy
  end
end
