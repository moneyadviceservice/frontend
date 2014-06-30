module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :logged_in?
  end

  def current_user
    warden.user
  end

  def logged_in?
    warden.try(:user).present?
  end

  private

  def warden
    env['warden']
  end

end
