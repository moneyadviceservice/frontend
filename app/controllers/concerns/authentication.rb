module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :user_signed_in?
    before_action :store_location
  end

  private

  def user_signed_in?
    session.keys.member?('warden.user.user.key')
  end

  def store_location
    session[:user_return_to] = request.fullpath
  end
end
