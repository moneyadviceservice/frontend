class SessionsController < Devise::SessionsController
  skip_before_action :store_location

  def new
    self.resource = resource_class.new(sign_in_params)
    self.resource.errors.add(:base, flash[:alert]) if flash[:alert]
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

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
