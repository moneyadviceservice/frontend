class SearchResultsController < ApplicationController
  include SearchResultsHelper
  decorates_assigned :search_results, with: SearchResultCollectionDecorator

  def index
    return if params[:query].blank?

    @search_results = SiteSearch::Query.new(
      params[:query],
      options: {
        index: ENV['ALGOLIA_SEARCH_INDEX'],
        highlightPreTag: '<b>',
        highlightPostTag: '</b>',
        page: index_zero_page,
        hitsPerPage: 10
      }
    ).results

    return render 'search_results/index_with_results' if @search_results.any?

    render 'search_results/index_no_results'
  end
end
