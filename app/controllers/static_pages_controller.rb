class StaticPagesController < ApplicationController
  decorates_assigned :static_page, with: ContentItemDecorator

  def show
    @static_page = Core::StaticPageReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@static_page, category_tree)
  end
end
