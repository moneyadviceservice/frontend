class AdvicesController < ApplicationController
  def show
    @breadcrumbs = BreadcrumbTrail.home
  end
end
