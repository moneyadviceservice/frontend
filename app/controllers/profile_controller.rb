class ProfileController < ArticlesController
  before_action :authenticate_user!

  def edit
  end

  def update
    current_user.update_goal!(params[:goal_statement], params[:goal_deadline])
    flash[:success] = I18n.t('profile.update.save_success_message')

    render :edit
  end

  private

  def saved_tools
    t('saved_tools.tools').keys.map do |tool_name|
      Core::Registry::Repository[:saved_tools].new(tool_name) if current_user.data_for?(tool_name)
    end.compact
  end
  helper_method :saved_tools
end
