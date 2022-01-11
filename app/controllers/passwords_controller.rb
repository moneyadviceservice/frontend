class PasswordsController < Devise::PasswordsController
  skip_before_action :store_location

  private

  def after_resetting_password_path_for(*)
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
    "#{ENV.fetch('MONEY_HELPER_URL')}#{path}"
  end
end
