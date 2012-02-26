class ApplicationController < ActionController::Base
  include Rack::Recaptcha::Helpers

  protect_from_forgery

  helper_method :logged_in?

  protected

  def logged_in?
    return session[:logged_in]
  end

  def authorize
    unless logged_in?
      respond_to do |format|
        format.html { redirect_to root_url, :alert => 'You are not authorized to do that.' }
        format.json  { head :forbidden }
      end
    end
  end
end
