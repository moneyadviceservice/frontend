require 'core/interactors/searcher'

class SearchResultsController < ApplicationController
  decorates_assigned :search_results, with: SearchResultDecorator

  def index
    @dont_show_search_box = true

    if params[:query].present?
      @search_results = Core::Searcher.new(params[:query]).call
      if @search_results.present?
        render 'search_results/index_with_results'
      else
        render 'search_results/index_no_results'
      end
    end
  end
end
