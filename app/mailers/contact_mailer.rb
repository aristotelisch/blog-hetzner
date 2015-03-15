class ContactMailer < ApplicationMailer
  default from: "telischristou@gmail.com"

  def contact_email(contact, request)
    @contact = contact
    @request = request.remote_ip
    mail(to: 'telischristou@gmail.com', subject: 'A new contact from happybit.eu')
  end

end
