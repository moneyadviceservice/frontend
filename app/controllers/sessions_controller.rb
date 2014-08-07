class SessionsController < Devise::SessionsController
  skip_before_action :store_location

  private

  def after_sign_in_path_for(resource)
    session[:user_return_to] || root_path
  end

  def set_flash_message(key, kind, options = {})
    super

    flash[:success] = flash[:notice]
    flash[:notice] = nil
  end
end
