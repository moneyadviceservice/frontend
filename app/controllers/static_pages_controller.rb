require 'core/interactors/static_page_reader'

class StaticPagesController < ApplicationController
  decorates_assigned :static_page, with: ContentItemDecorator

  def show
    @static_page = Core::StaticPageReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = [Breadcrumb.new(nil)]
  end
end
