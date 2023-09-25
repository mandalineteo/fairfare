class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update]

  def filter
    nickname = params[:nickname]

    @contacts = current_user.contacts.where("nickname ILIKE ?", "%#{nickname}%")
    @split = Split.find(params[:split_id])

    respond_to do |format|
      format.json do
        render json: {
          contacts: render_to_string(
            partial: "splits/contact_list",
            locals: { available_contacts: @contacts, split: @split },
            formats: [:html]
          ),
          total_count: @contacts.size
        }
      end
    end
  end

  def index
    @contacts = Contact.all
  end

  def show
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to user_contacts_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:nickname) # what if I want to allow changing of phone number
  end
end
