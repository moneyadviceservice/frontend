require 'core/interactors/static_page_reader'
require 'core/interactors/category_parents_reader'

class StaticPagesController < ApplicationController

  decorates_assigned :static_page, with: StaticPageDecorator

  def show
    @static_page = Core::StaticPageReader.new(params[:id]).call do
      not_found
    end
  end
end
