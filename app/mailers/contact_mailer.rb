class ContactMailer < ActionMailer::Base
  default from: "no-reply@annette-robinson.com"

  def contact_email(message)
    @message = message
    mail to: "",
      subject: "You have received a message from a visitor to your website"
  end
end
