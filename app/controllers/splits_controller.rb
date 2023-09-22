require 'securerandom'

class SplitsController < ApplicationController
  def index
    @splits = current_user.member.splits
  end

  def show
    @split = Split.find(params[:id])
  end

  def new
    @split = Split.new
  end

  def update
    @split = Split.find(params[:id])
    @split.update(split_params)

    respond_to do |format|
      format.text { render plain: @split.name }
    end
  end

  def create
    @split = Split.new(split_params)
    @split.invite_code = SecureRandom.hex(13)
    @split.user = current_user
    if @split.save
      # ask ashley later why need to save first
      @split.members << current_user.member
      @split.save
      redirect_to split_add_members_path(@split)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add_existing_contact
    @split = Split.find(params[:split_id])
    @member = Member.find(params[:member_id])
    @split.members << @member

    redirect_to split_add_members_path(@split)
  end

  def add_members
    @split = Split.find(params[:split_id])

    @available_contacts = current_user.contacts.reject do |contact|
      @split.members.include?(contact.member)
    end

    @split_member = SplitMember.new(split: @split)
  end

  def destroy
  end

  private

  def split_params
    params.require(:split).permit(:name, :date)
  end
end
