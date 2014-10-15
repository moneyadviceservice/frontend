class ProfileController < ArticlesController
  before_action :require_sign_in

  def edit
  end

  def update
    current_user.goal_text = params[:goal_text]
    current_user.goal_date = params[:goal_date]
    current_user.save!

    render :edit
  end

  private

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
