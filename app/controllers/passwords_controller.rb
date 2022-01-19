class PasswordsController < Devise::PasswordsController
  skip_before_action :store_location

  # PUT /resource/password
  # We have to override this with the default devise implementation but
  # instead of responding with the resource and location we have to
  # redirect to an external URL to ensure the end user isn't left
  # outside of the embedded environment
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
        logger.info('Password reset and signed in')
      else
        set_flash_message!(:notice, :updated_not_active)
        logger.info('Password reset failed')
      end
      logger.info("Redirecting after password reset: #{after_resetting_password_url}")
      redirect_to after_resetting_password_url, status: :see_other
    else
      logger.info('Password reset failed with validation issues')
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def after_resetting_password_url
    case session[:user_return_to]
    when /money-manager/
      money_helper_url_for('/en/benefits/universal-credit/money-manager-my-profile')
    when /budget-planner/
      money_helper_url_for('/en/everyday-money/budgeting/budget-planner-my-profile')
    else
      money_helper_url_for('/en/users/my-profile')
    end
  end

  def set_flash_message(key, kind, options = {})
    super

    flash[:success] = flash[:notice]
    flash.delete(:notice)
  end

  def money_helper_url_for(path)
    "#{ENV['MONEY_HELPER_URL']}#{path}"
  end
end
