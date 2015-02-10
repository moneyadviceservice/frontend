class CorporateController < ApplicationController
  decorates_assigned :corporate, with: ContentItemDecorator
  include Navigation

  def show
    @corporate = Core::CorporateReader.new(params[:id]).call do
      not_found
    end

    assign_active_categories(*@corporate.categories)

    @breadcrumbs = BreadcrumbTrail.build(@corporate, category_tree)
  end
end
