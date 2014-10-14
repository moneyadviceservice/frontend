module Core
  class Searcher
    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 10
    PAGE_LIMIT = 5

    attr_accessor :query
    attr_reader :page, :per_page

    private :query=

    def initialize(query, options = {})
      self.query = query
      self.page = options.fetch(:page, DEFAULT_PAGE).to_i
      self.per_page = options.fetch(:per_page, DEFAULT_PER_PAGE).to_i
    end

    def call
      SearchResultCollection.new(options).tap do |results_collection|
        items.each do |result_data|
          new_result = SearchResult.new(result_data.delete(:id), result_data)
          if new_result.valid?
            results_collection << new_result
          else
            Rails.logger.info("Invalid search result: #{new_result.inspect}")
          end
        end
      end
    end

    private

    def options
      {
        total_results: total_results,
        page: page,
        per_page: per_page,
        spelling_suggestion: spelling_suggestion,
        query: query
      }
    end

    def page=(new_page)
      @page = if new_page > 0
                [new_page, PAGE_LIMIT].min
              else
                DEFAULT_PAGE
              end
    end

    def per_page=(new_per_page)
      @per_page = [new_per_page, DEFAULT_PER_PAGE].min
    end

    def data
      @data ||= Registry::Repository[:search].perform(query, page, per_page)
    end

    def total_results
      data[:total_results]
    end

    def items
      data[:items]
    end

    def spelling_suggestion
      data[:spelling_suggestion]
    end
  end
end
