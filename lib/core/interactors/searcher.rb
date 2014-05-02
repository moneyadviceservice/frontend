require 'core/entities/search_result_collection'
require 'core/entities/search_result'
require 'core/registries/repository'

module Core
  class Searcher
    attr_accessor :query, :page

    private :query=

    def initialize(query, page = 1)
      self.query = query
      self.page = page
    end

    def call
      data = Registries::Repository[:search].perform(query, page)
      SearchResultCollection.new(query, data.slice(:total_results, :page, :per_page)).tap do |results_collection|
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
