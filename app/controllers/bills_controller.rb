class BillsController < ApplicationController
  def new
    @split = Split.find(params[:split_id])
    @bill = Bill.new
  end

  # def show
  #   @bill = Bill.find(params[:id])
  #   data = @bill.receipt_data

  #   items = []
  #   items << Item.new(...)

  #   puts items

  #   render json: { data: } # this is to show the json code on the webpage in local
  # transfer this to the items controller #index method instead and list out the items on the html.erb file
  # end

  def receipt
    @split = Split.find(params[:split_id])
  end

  def upload
    @bill = Bill.create(split_id: params[:split_id])
    @bill.photo = params[:image]

    if @bill.save
      # schedule a background job
      ParseReceiptJob.perform_later(@bill)

      redirect_to root_path # change to loading page
    else
      raise
    end
  end
end
