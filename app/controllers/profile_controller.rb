class ProfileController < ArticlesController
  before_action :require_sign_in

  def edit
  end

  private

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
