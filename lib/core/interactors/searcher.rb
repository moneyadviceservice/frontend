require 'core/entities/search_result_collection'
require 'core/entities/search_result'
require 'core/registries/repository'

module Core
  class Searcher
    attr_accessor :query

    private :query=

    def initialize(query)
      self.query = query
    end

    def call
      data = Registries::Repository[:search].perform(query)
      SearchResultCollection.new(query).tap do |results_collection|
        data.each do |result_data|
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
