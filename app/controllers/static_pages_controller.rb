class StaticPagesController < ApplicationController
  decorates_assigned :static_page, with: ContentItemDecorator

  CONTACT_PAGE_ID_EN = 'contact-us'
  CONTACT_PAGE_ID_CY = 'cysylltu-a-ni'

  def show
    @breadcrumbs = BreadcrumbTrail.home

    if [CONTACT_PAGE_ID_EN, CONTACT_PAGE_ID_CY].include?(params[:id])
      render :template => 'static_pages/show_contact_us'
    else
      @static_page = Core::StaticPageReader.new(params[:id]).call do
        not_found
      end
    end
  end
end
