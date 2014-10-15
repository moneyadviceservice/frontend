class ProfileController < ArticlesController
  before_action :require_sign_in

  def edit
  end

  def update
    current_user.goal_statement = params[:goal_statement]
    current_user.goal_deadline = params[:goal_deadline]
    current_user.save!

    render :edit
  end

  private

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
