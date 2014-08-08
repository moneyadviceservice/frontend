class SessionsController < Devise::SessionsController
  skip_before_action :store_location

  private

  def after_sign_in_path_for(resource)
    last_known_path_or_root_path
  end

  def after_sign_out_path_for(resource)
    last_known_path_or_root_path
  end

  def set_flash_message(key, kind, options = {})
    super

    flash[:success] = flash[:notice]
    flash[:notice] = nil
  end

  def last_known_path_or_root_path
    session[:user_return_to] || root_path
  end
end
