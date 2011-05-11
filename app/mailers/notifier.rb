class Notifier < ActionMailer::Base
  default :from => "no-reply@annette-robinson.com"

  def message_notification(name, email, message)
    @name = name
    @email = email
    @message = message

    mail(:to => '',
         :subject => 'You have received a new message from a visitor to your website!')
  end
end
