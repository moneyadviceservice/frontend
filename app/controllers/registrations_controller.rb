class RegistrationsController < Devise::RegistrationsController
  before_action :store_pre_auth_location, only: [:new]
  before_action :configure_permitted_parameters

  def edit
    head :not_implemented
  end

  protected

  def build_resource(hash=nil)
    hash[:accept_terms_conditions] = true if hash
    super(hash)
  end

  private

  def store_pre_auth_location
    session[:pre_auth_location] = referer
  end

  def after_sign_up_path_for(resource)
    session[:pre_auth_location] || root_path
  end

  def set_flash_message(key, kind, options = {})
    super

    flash[:success] = flash[:notice]
    flash[:notice] = nil
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :post_code
    devise_parameter_sanitizer.for(:sign_up) << :newsletter_subscription
  end
end
