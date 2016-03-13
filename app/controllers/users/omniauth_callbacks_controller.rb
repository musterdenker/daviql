module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    rescue_from LoginService::AuthenticationError, with: :handle_auth_error

    skip_before_filter :authenticate_user!

    def google_oauth2
      auth_hash = request.env["omniauth.auth"]

      @user = LoginService.from_omniauth(auth_hash)

      if @user.persisted?
        sign_in_and_redirect @user
      else
        raise LoginService::AuthenticationError.new("Account not persisted! Weird!")
      end
    end

    def failure
      @message = "OAuth failed!"
      render :auth_error
    end

    private

    def after_sign_in_path_for(resource)
      root_path
    end

    def handle_auth_error(e)
      @message = e.message.blank? ? "Sorry, could not authenticate your credentials." : e.message
      render :auth_error
    end
  end
end
