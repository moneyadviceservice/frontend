require 'core/entities/search_result'

module Core
  class SearchResultCollection < Entity

    attr_accessor :page, :per_page, :total_results

    attr_writer :items

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
  end
end
