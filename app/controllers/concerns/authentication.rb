module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :user_signed_in?
  end

  private

  def user_signed_in?
    session.keys.member? 'warden.user.user.key'
  end
end
