class RetirementsController < ApplicationController
  layout 'layouts/_unconstrained'
  helper_method :locale_options

  def locale_options
    LandingPagePaths.locale_options(params[:controller], params[:action])
  end

  def display_menu_button_in_header?
    false
  end
end
