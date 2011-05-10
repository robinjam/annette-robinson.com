ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'paperclip/matchers'

class ActiveSupport::TestCase
  extend  Paperclip::Shoulda::Matchers

  # Add more helper methods to be used by all tests here...
  def log_in
    session[:logged_in] = true
  end
end
