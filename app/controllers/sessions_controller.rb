class SessionsController < ApplicationController
  def create
    username = params[:username]
    password = params[:password]

    if username == 'annette' && Digest::SHA512.hexdigest("#{password}:cheesecake") == '788ff873910337c9d9443bbd6e9c2b99d7c8647c7571873a3ace3b51e23da595e54d60a40c7e317cd1ff73ee286d1e283af8c13e4145bfbc282fbd57ca83601d' # TODO: Move to config file?
      session[:logged_in] = true
      redirect_to root_url, :notice => 'Login successful.'
    else
      flash.now[:alert] = 'Incorrect username or password.'
      render :new
    end
  end

  def destroy
    session[:logged_in] = false
    redirect_to root_url, :notice => 'You have logged out.'
  end
end
