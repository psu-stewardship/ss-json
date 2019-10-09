class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def psu
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
            # @user.update_doorkeeper_credentials(request.env["omniauth.auth"])
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "Penn State") if is_navigational_format?
          else
            session["devise.doorkeeper_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
          end
      
        def failure
          redirect_to root_path
        end
    end
end