class StaticPagesController < ApplicationController
  decorates_assigned :static_page, with: ContentItemDecorator
  skip_before_action :store_location, if: :auth_related_page?

  def show
    @static_page = Core::StaticPageReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@static_page, category_tree)

    if template_exists?("/static_pages/#{params[:id].underscore}")
      render template: "/static_pages/#{params[:id].underscore}"
    else
      render :show
    end
  end

  private

  def auth_related_page?
    ['privacy', 'terms-and-conditions'].include?(params[:id])
  end
end
