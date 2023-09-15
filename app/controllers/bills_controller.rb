class BillsController < ApplicationController


  def new
    @split = Split.find(params[:split_id])
    @bill = Bill.new

  end

  def create
  end


end
