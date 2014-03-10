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
      Registries::Repository[:search].perform(query).each_with_object([]) do |result_data, memo|
        new_result = SearchResult.new(result_data.delete(:id), result_data)
        if new_result.valid?
          memo << new_result
        else
          Rails.logger.info("Invalid search result: #{new_result.inspect}")
        end
      end
    end
  end
end
