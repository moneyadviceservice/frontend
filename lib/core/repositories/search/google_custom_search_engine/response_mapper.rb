require 'core/repositories/search/google_custom_search_engine/response_item_mapper'

module Core::Repositories
  module Search
    class GoogleCustomSearchEngine < Core::Repository
      class ResponseMapper
        def initialize(response)
          @body = response.body
        end

        def mapped_response
          {
            total_results: total_results,
            page: page,
            per_page: per_page,
            items: items
          }
        end

        private

        attr_reader :body

        def items
          body.fetch('items', []).map do |item_hash|
            ResponseItemMapper.new(item_hash).mapped_item_response
          end
        end

        def paging_metadata
          body['queries']['request'].first
        end

        def total_results
          paging_metadata['totalResults'].to_i
        end

        def per_page
          paging_metadata['count'].to_i
        end

        def offset
          paging_metadata['startIndex'].to_i - 1
        end

        def page
          (offset / per_page) + 1
        end
      end
    end
  end
end
