class LandingPagesController < ApplicationController
  def show
    @breadcrumbs = BreadcrumbTrail.home
    render layout: '_unconstrained'
  end
end
