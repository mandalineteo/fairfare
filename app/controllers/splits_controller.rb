class SplitsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @split = Split.new
  end

  def create
    @split = Split.new(split_params)
    @split.user = current_user
    if @split.save
      redirect_to new_member_split_path
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
