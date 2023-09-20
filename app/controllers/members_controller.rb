class MembersController < ApplicationController
  def create
    @member = Member.new(member_params)
    @split = Split.find(params[:split_id])

    if @member.save
      @split.members << @member
      redirect_to split_add_members_path(@split)
    else
      #To update
    end
  end

  private

  def member_params
    params.require(:member).permit(:phone_number)
  end
end
