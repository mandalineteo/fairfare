require 'securerandom'

class SplitsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @split = Split.new
  end

  def create
    @split = Split.new(split_params)
    @split.invite_code = SecureRandom.hex(13)
    @split.user = current_user
    if @split.save
      redirect_to new_split_split_member_path(@split)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def add_members
    @split = Split.find(params[:split_id])
    @member = Member.new
  end

  private

  def split_params
    params.require(:split).permit(:name, :date)
  end
end
