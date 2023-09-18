class MembersController < ApplicationController
  def create
    @member = Member.new(member_params)
    @split = Split.find(params[:split_id])

    if @member.save
      @split.members << @member
      redirect_to split_add_members_path(@split)
    else
    end
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :phone_number)
  end
end
