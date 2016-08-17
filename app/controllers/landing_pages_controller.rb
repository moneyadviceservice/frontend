class LandingPagesController < ApplicationController
  include SuppressMenuButton

  def display_skip_to_main_navigation?
    false
  end

  def show
    @breadcrumbs = BreadcrumbTrail.home
    render layout: '_unconstrained'
  end
end
