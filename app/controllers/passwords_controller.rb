class PasswordsController < Devise::PasswordsController
  skip_before_action :store_location

  private

  def after_resetting_password_path_for(_resource)
    session[:user_return_to] || root_path
  end
end
