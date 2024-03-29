class SessionsController < Devise::SessionsController
  skip_before_action :store_location
  before_action :xhr_not_implemented, only: [:new]

  def display_skip_to_main_navigation?
    false
  end

  def new
    # This method is mostly copied devise code
    # With one tweak to add the error to resource from the flash hash
    self.resource = resource_class.new(sign_in_params)
    resource.errors.add(:base, flash[:alert]) if flash[:alert]
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  def destroy
    session.delete('claimant_data_id')
    super
  end

  private

  def default_url_options(options = {})
    if params.key?(:noresize)
      options.merge(noresize: true)
    else
      super
    end
  end

  def xhr_not_implemented
    head :not_implemented if request.xhr?
  end

  def after_sign_in_path_for(*)
    session[:user_return_to] || edit_profile_path
  end

  def after_sign_out_path_for(resource_name)
    session[:user_return_to] || new_session_path(resource_name)
  end
end
