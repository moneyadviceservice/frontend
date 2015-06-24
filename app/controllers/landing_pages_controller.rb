class LandingPagesController < ApplicationController
  include SuppressMenuButton

  def show
    @breadcrumbs = BreadcrumbTrail.home
    render layout: '_unconstrained'
  end
end
