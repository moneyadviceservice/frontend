class RetirementsController < ApplicationController
  layout 'layouts/_unconstrained'
  helper_method :locale_options

  def locale_options
    if Feature.active? :welsh_retirement_landing_pages
      LandingPagePaths.locale_options(params[:controller], params[:action])
    else
      []
    end
  end

  def alternate_locales
    return if Feature.active? :welsh_retirement_landing_pages
    []
  end

  def display_menu_button_in_header?
    false
  end
end
