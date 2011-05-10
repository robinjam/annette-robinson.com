class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?

  protected

  def logged_in?
    return session[:logged_in]
  end

  def authorize
    redirect_to root_url, :alert => 'You are not authorized to do that.' unless logged_in?
  end
end
