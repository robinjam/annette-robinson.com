class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      if @message.website.blank?
        ContactMailer.contact_email(@message).deliver
      else
        logger.warn "A spammer attempted to send a message using the Contact Me form. The message was blocked."
      end
      flash[:notice] = 'Message sent! Thank you for contacting me.'
      redirect_to root_url
    else
      render :new
    end
  end
end
