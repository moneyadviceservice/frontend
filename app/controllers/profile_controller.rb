class ProfileController < ArticlesController
  before_action :require_sign_in

  def edit
  end

  def update
    current_user.update_goal!(params[:goal_statement], params[:goal_deadline])

    render :edit
  end

  private

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
