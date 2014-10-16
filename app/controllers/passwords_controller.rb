class PasswordsController < Devise::PasswordsController
  skip_before_action :store_location

  private

    def after_resetting_password_path_for(*)
      session[:user_return_to] || root_path
    end

    def set_flash_message(key, kind, options = {})
      super

      flash[:success] = flash[:notice]
      flash[:notice] = nil
    end
end
