class LandingPagesController < ApplicationController
  def show
    @breadcrumbs = BreadcrumbTrail.home
    render layout: '_unconstrained'
  end

  def display_menu_button_in_header?
    false
  end
end
