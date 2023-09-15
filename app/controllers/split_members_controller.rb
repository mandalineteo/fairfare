class SplitMembersController < ApplicationController
  def new
    split_id = params[:split_id]
    @split = Split.find(split_id)
    @split_member = SplitMember.new
  end

  def create
    split_id = params[:split_id]
    @split = Split.find(split_id)
    @split_member = SplitMember.new

    # if @split_member.save
    # else
    # end
  end
end
