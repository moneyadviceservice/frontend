class RetirementsController < ApplicationController
  layout 'layouts/_unconstrained'
  helper_method :locale_options

  include SuppressMenuButton

  def locale_options
    LandingPagePaths.locale_options(params[:controller], params[:action])
  end
end
