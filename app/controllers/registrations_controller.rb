class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location
  before_action :configure_permitted_parameters

  include SuppressMenuButton

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
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :post_code
    devise_parameter_sanitizer.for(:sign_up) << :opt_in_for_research
    devise_parameter_sanitizer.for(:sign_up) << :contact_number
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :post_code
    devise_parameter_sanitizer.for(:account_update) << :opt_in_for_research
    devise_parameter_sanitizer.for(:account_update) << :contact_number
  end
end
