class MembersController < ApplicationController
  def filter
    # first_name = params[:filter]
    # last_name = params[:filter]

    # contacts = current_user.contacts
    #             .where("lower(members.first_name) LIKE ?", "#{first_name.downcase}%")
    #             .where("lower(members.last_name) LIKE ?", "#{last_name.downcase}%")

    first_name = params[:first_name]
    last_name = params[:last_name]
    phone_number = params[:phone_number]

    @members = current_user.contacts
              .where("first_name ILIKE '%#{first_name}%'")
              .where("last_name ILIKE '%#{last_name}%'")
              .where("phone_number ILIKE '%#{phone_number}%'")

    respond_to do |format|
      format.json do
        render json: { members: @members }
        # render json: { contacts: render_to_string(partial: "splits/contact_list", locals: { contacts: }, formats: [:html]) }
      end
    end
  end

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
