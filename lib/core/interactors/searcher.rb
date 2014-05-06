require 'core/entities/search_result_collection'
require 'core/entities/search_result'
require 'core/registries/repository'

module Core
  class Searcher

    DEFAULT_PAGE = 1
    DEFAULT_RESULTS_PER_PAGE = 10

    attr_accessor :query, :page, :per_page

    private :query=

    def initialize(query, page = DEFAULT_PAGE, per_page = DEFAULT_RESULTS_PER_PAGE)
      self.query = query
      self.page = page
      self.per_page = per_page
    end

    def call
      data = Registries::Repository[:search].perform(query, page, per_page)
      options = data.slice(:total_results).merge(page: page, per_page: per_page)
      SearchResultCollection.new(query, options).tap do |results_collection|
        data[:items].each do |result_data|
          new_result = SearchResult.new(result_data.delete(:id), result_data)
          if new_result.valid?
            results_collection.items << new_result
          else
            Rails.logger.info("Invalid search result: #{new_result.inspect}")
          end
        end
      end
    end
  end
end
