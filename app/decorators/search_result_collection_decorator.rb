class SearchResultCollectionDecorator < Draper::CollectionDecorator
  delegate :per_page, :number_of_pages

  def decorator_class
    SearchResultDecorator
  end

  def context
    { query: object.query }
  end

  def page
    object.page + 1
  end

  def first_page?
    page == 1
  end

  def last_page?
    page == number_of_pages
  end

  def previous_page
    first_page? ? nil : object.page - 1
  end

  def next_page
    last_page? ? nil : object.page + 1
  end

  private

  def search_path(query)
    h.search_results_path(query: query, locale: I18n.locale)
  end
end
