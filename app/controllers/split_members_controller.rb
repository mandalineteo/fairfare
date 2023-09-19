class SplitMembersController < ApplicationController
  def create
    # check if member_id is present in params
    if params[:member_id].present?
      @split = Split.find(params[:split_id])
      @member = Member.find(params[:member_id])
      @split.member << @member
    else
      # if no, means contact not selected.
      @member = Member.find_by(phone_number: params[:phone_number])
      # check if phone_number belongs to existing member
      if @member.nil?
        redirect_to
        # if yes, find that member
      # else
        # create new member
  end
end
