require 'www_redirect'

Rails.application.config.middleware.use WwwRedirect if Rails.env.production?
