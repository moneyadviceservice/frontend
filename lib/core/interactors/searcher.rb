require 'core/entities/search_result_collection'
require 'core/entities/search_result'
require 'core/registries/repository'

module Core
  class Searcher

    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 10

    attr_accessor :query
    attr_writer :page, :per_page

    private :query=, :page=, :per_page=

    def initialize(query, page = nil, per_page = nil)
      self.query = query
      self.page = page if page
      self.per_page = per_page if per_page
    end

    def call
      options = { total_results: total_results, page: page, per_page: per_page }
      SearchResultCollection.new(query, options).tap do |results_collection|
        items.each do |result_data|
          new_result = SearchResult.new(result_data.delete(:id), result_data)
          if new_result.valid?
            results_collection.items << new_result
          else
            Rails.logger.info("Invalid search result: #{new_result.inspect}")
          end
        end
      end
    end

    private

    def data
      @data ||= Registries::Repository[:search].perform(query, page, per_page)
    end

    def page
      @page ||= DEFAULT_PAGE
    end

    def per_page
      @per_page ||= DEFAULT_PER_PAGE
    end

    def total_results
      data[:total_results]
    end

    def items
      data[:items]
    end
  end
end
