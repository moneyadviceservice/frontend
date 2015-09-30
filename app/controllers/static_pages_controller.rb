class StaticPagesController < ApplicationController
  decorates_assigned :static_page, with: ContentItemDecorator

  def show
    @static_page = Core::StaticPageReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.home

    if template_exists?("/static_pages/#{params[:id].underscore}")
      render template: "/static_pages/#{params[:id].underscore}"
    else
      render :show
    end
  end
end
