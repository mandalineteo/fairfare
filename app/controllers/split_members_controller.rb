class SplitMembersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @split_member = Split_member.new
  end

  def create
  end
end
