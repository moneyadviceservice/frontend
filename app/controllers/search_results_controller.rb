class SearchResultsController < ApplicationController
  decorates_assigned :search_results, with: SearchResultCollectionDecorator

  def index
    return if params[:query].blank?

    @search_results = SiteSearch::Query.new(
      params[:query],
      options: {
        index: 'pages',
        highlightPreTag: '<b>',
        highlightPostTag: '</b>',
        page: params[:page],
        hitsPerPage: 10
      }
    ).results

    if @search_results.any?
      render 'search_results/index_with_results'
    else
      render 'search_results/index_no_results'
    end
  end

  private

  def display_search_box_in_header?
    false
  end
end
