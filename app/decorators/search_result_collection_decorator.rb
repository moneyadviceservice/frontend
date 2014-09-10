class SearchResultCollectionDecorator < Draper::CollectionDecorator
  delegate :per_page

  def decorator_class
    SearchResultDecorator
  end

  def context
    { query: object.query }
  end

  def page
    if object.page > number_of_pages
      number_of_pages
    else
      object.page
    end
  end

  def total_results
    if object.total_results > result_limit
      result_limit
    else
      object.total_results
    end
  end

  def first_page?
    page == 1
  end

  def last_page?
    page == number_of_pages
  end

  def previous_page
    first_page? ? nil : page - 1
  end

  def next_page
    last_page? ? nil : page + 1
  end

  def number_of_pages
    total_results <= per_page ? 1 : (((total_results - 1) / per_page) + 1)
  end

  def spelling_suggestion
    return unless object.spelling_suggestion?

    I18n.t(
      'search_results.spelling_suggestion_html',
      link: spelling_link,
      query: object.query
    ).html_safe
  end

  def corrected_query
    return unless object.corrected_query?

    I18n.t('search_results.spelling_correction_html', query: object.query).html_safe
  end

  private

  def spelling_link
    h.link_to(object.spelling_suggestion, search_path(object.spelling_suggestion))
  end

  def search_path(query)
    h.search_results_path(query: query, locale: I18n.locale)
  end

  def result_limit
    Core::Searcher::PAGE_LIMIT * Core::Searcher::DEFAULT_PER_PAGE
  end
end
