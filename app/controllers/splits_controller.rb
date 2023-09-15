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
      redirect_to split_members_new_path(split_id: @split.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def split_params
    params.require(:split).permit(:name, :date)
  end
end
