class BillsController < ApplicationController
  def new
    @split = Split.find(params[:split_id])
    @bill = Bill.new
  end

  def receipt
    @split = Split.find(params[:split_id])
  end

  def upload
    @bill = Bill.create(split_id: params[:split_id])
    @bill.photo = params[:image]

    if @bill.save
      # schedule a background job
      ParseReceiptJob.perform_later(@bill)
      redirect_to root_path
    else
      raise
    end
  end
end
