class RetirementsController < ApplicationController
  layout 'layouts/_unconstrained'
  helper_method :locale_options

  def display_skip_to_main_navigation?
    false
  end

  def locale_options
    LandingPagePaths.locale_options(params[:controller], params[:action])
  end
end
