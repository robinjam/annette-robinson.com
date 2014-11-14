class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :admin?

  protected

  def logged_in?
    return !User.find_by_id(session[:user_id]).nil?
  end

  def admin?
    return User.find_by_id(session[:user_id]).try(:admin?)
  end

  def authorize
    unless admin?
      respond_to do |format|
        format.html { redirect_to root_url, :alert => 'You are not authorized to do that.' }
        format.json  { head :forbidden }
      end
    end
  end
end
