class AdvicesController < ApplicationController
  def show
    @breadcrumbs = BreadcrumbTrail.home
  end

  def display_opt_out_link_in_footer?
    false
  end
end
