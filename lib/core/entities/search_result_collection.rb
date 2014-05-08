require 'core/interactors/searcher'
require 'core/entities/search_result'

module Core
  class SearchResultCollection < Entity

    attr_accessor :per_page

    attr_writer :page, :total_results, :items

    def page
      if @page && @page > number_of_pages
        number_of_pages
      else
        @page
      end
    end

    def total_results
      if @total_results && @total_results > result_limit
        result_limit
      else
        @total_results
      end
    end

    def items
      @items ||= []
    end

    def any?
      items.present?
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
      Searcher::PAGE_LIMIT * Searcher::PER_PAGE_LIMIT
    end
  end
end
