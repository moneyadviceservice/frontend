class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location
  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    resource.validate # Look for any other validation errors besides Recaptcha
    if verify_recaptcha(model: resource, attribute: 'recaptcha')
      super
    else
      respond_with_navigational(resource) { render :new }
    end
  end

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

  def after_update_path_for(*)
    edit_profile_path
  end

  def after_sign_up_path_for(*)
    session[:user_return_to] || edit_profile_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name post_code opt_in_for_research contact_number])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name post_code opt_in_for_research contact_number])
  end
end
