class ProfileController < ApplicationController
  before_action :authenticate_user!

  def edit; end

  def update
    current_user.update_goal!(params[:goal_statement], params[:goal_deadline])
    flash[:success] = I18n.t('profile.update.save_success_message')

    render :edit
  end

  def display_skip_to_main_navigation?
    false
  end

  def default_main_content_location?
    true
  end

  private

  def noresize
    '?noresize=true' if params.key?(:noresize)
  end
  helper_method :noresize

  def saved_tools
    t('saved_tools.tools').select do |tool_name, _|
      current_user.data_for?(tool_name)
    end
  end
  helper_method :saved_tools

  def recommended_tools
    recommended_tool_names = I18n.t('recommended_tools.tools').keys.reject do |tool_name|
      current_user.data_for?(tool_name)
    end

    recommended_tool_names.map do |tool_name|
      Core::Registry::Repository[:recommended_tool_class].new(tool_name)
    end
  end
  helper_method :recommended_tools
end
