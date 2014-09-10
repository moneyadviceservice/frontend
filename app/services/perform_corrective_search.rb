class PerformCorrectiveSearch

  def initialize(query, page)
    @query = query
    @page  = page
  end

  def call
    search_results = Core::Searcher.new(@query, page: @page).call

    if search_results.empty? && search_results.spelling_suggestion?
      Core::Searcher.new(search_results.spelling_suggestion, page: @page).call.tap do |corrected_search_results|
        corrected_search_results.corrected_query = search_results.spelling_suggestion
      end
    else
      search_results
    end
  end
end
