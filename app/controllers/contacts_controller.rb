class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      # Todo send email
      flash[:notice] = "Message sent from #{@contact.name}"
      ContactMailer.contact_email(@contact, request).deliver_now
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end

end
