require 'core/interactors/searcher'

class SearchResultsController < ApplicationController
  decorates_assigned :search_results, with: SearchResultDecorator

  def index
    if params[:query].present?
      search_result_collection = Core::Searcher.new(params[:query]).call

      if search_result_collection.any?
        @search_results = search_result_collection.items
        render 'search_results/index_with_results'
      else
        render 'search_results/index_no_results'
      end
    end
  end

  private

  def display_search_box_in_header?
    false
  end
end
