class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location
  before_action :configure_permitted_parameters

  def display_skip_to_main_navigation?
    false
  end

  protected

  def build_resource(hash = nil)
    if hash
      hash[:accept_terms_conditions] = true
      hash[:newsletter_subscription] = false
    end
    super
  end

  private

  def after_sign_up_path_for(*)
    session[:user_return_to] || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :post_code, :opt_in_for_research, :contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :post_code, :opt_in_for_research, :contact_number])
  end
end
