class PagesController < ApplicationController
  def contact
    
  end

  def send_mail
    redirect_to root_url, :notice => 'Thank you for your message.' unless params[:website].empty?
    @name, @email, @message = params[:name], params[:email], params[:message]
    if @name.blank? || @email.blank? || @message.blank?
      flash.now[:alert] = 'Please fill in all of the fields.'
      render :contact
    elsif (/[^@]+[^\.]+\.[^\.]+/ =~ @email).nil?
      flash.now[:alert] = 'Please fill in a valid email address.'
      render :contact
    else
      Notifier.message_notification(@name, @email, @message).deliver
      redirect_to root_url, :notice => 'Thank you for your message!'
    end
  end
end
