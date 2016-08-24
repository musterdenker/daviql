class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate_user!, :basic_auth

  helper_method :is_admin?, :current_user

  before_filter :set_paper_trail_whodunnit

  def basic_auth

    if Rails.application.config.use_basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.application.config.basic_auth_user && password == Rails.application.config.basic_auth_pw
      end
    end
  end

  def is_admin?
    current_user ? current_user.is_admin : false
  end

end
