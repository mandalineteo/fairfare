class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @split = Split.find(params[:split_id])
    @bill = Bill.new
    @bill.items.build
  end

  def create
    @split = Split.find(params[:split_id])
    @bill = Bill.new(bill_params)
    @bill.split = @split


    if @bill.save
      redirect_to :show
    else
      render :new
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:merchant, items_attributes: [:name, :price, :quantity])
  end

end
