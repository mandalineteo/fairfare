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
  end

  def destroy
  end
end
