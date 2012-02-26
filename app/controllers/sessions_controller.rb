class SessionsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    user = User.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Logged in successfully.'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'You have logged out.'
  end
end
