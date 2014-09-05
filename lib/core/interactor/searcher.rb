module Core
  class Searcher

    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 10

    PAGE_LIMIT = 5
    PER_PAGE_LIMIT = 10

    attr_accessor :query
    attr_writer :per_page
    attr_reader :page

    private :query=, :per_page=

    def initialize(query, options = {})
      self.query = query
      self.per_page = options[:per_page].to_i if options[:per_page]
      self.page = options.fetch(:page, DEFAULT_PAGE).to_i
    end

    def call
      options = { total_results: total_results, page: page, per_page: request_per_page }

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

    def page=(new_page)
      @page = if new_page > 0
        [new_page, PAGE_LIMIT].min
      else
        DEFAULT_PAGE
      end
    end

    def data
      @data ||= Registry::Repository[:search].perform(query, page, request_per_page)
    end

    def per_page
      @per_page ||= DEFAULT_PER_PAGE
    end

    def request_per_page
      [per_page, PER_PAGE_LIMIT].min
    end

    def total_results
      data[:total_results]
    end

    def items
      data[:items]
    end
  end
end
