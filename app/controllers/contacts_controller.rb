class ContactsController < ApplicationController
  def filter
    nickname = params[:nickname]

    contacts = current_user.contacts.where("nickname ILIKE ?", "%#{nickname}%")

    respond_to do |format|
      format.json do
        render json: { contacts: render_to_string(partial: "splits/contact_list", locals: { contacts: contacts } , formats: [:html]) }
      end
    end
  end
end
