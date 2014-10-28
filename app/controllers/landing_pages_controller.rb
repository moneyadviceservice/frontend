class LandingPagesController < ApplicationController
  def show
    @breadcrumbs = BreadcrumbTrail.home
  end
end
