class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    @captcha_valid = true
  end

  def create
    @contact = Contact.new(contact_params)
    @captcha_valid = verify_recaptcha

    if @contact.valid? && @captcha_valid
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
