class ContactMailer < ApplicationMailer
  default :from => 'f.sansalvadore@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(contact)
    @contact = contact
    mail( :to => @contact.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
