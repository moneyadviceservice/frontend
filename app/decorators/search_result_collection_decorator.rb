require 'core/interactors/searcher'

class SearchResultCollectionDecorator < Draper::Decorator
  decorates_association :items, with: SearchResultDecorator

  delegate :per_page

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

  private

  def result_limit
    Core::Searcher::PAGE_LIMIT * Core::Searcher::PER_PAGE_LIMIT
  end
end
