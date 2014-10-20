class ProfileController < ArticlesController
  before_action :authenticate_user!

  def edit
  end

  def update
    current_user.update_goal!(params[:goal_statement], params[:goal_deadline])
    flash[:success] = I18n.t('profile.update.save_success_message')

    render :edit
  end
end
