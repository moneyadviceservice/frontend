module Core::Repositories
  module Search
    class GoogleCustomSearchEngineResponseMapper
      SECOND_TO_LAST = -2

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
        raw_items = body.fetch('items', [])
        raw_items.map do |item|
          link_tokens = item['link'].split('/')
          {
            id:          link_tokens.last,
            type:        link_tokens[SECOND_TO_LAST].singularize,
            description: extract_description(item),
            title:       item['title'],
            link:        item['link'],
            snippet:     item['snippet']
          }
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

      def extract_description(item)
        return '' unless item.key?('pagemap')

        description = ''
        metatags_array = Array(item['pagemap']['metatags'])
        metatags_array.each do |metatags|
          metatags.each { |key, value| return description = value if key == 'og:description' }
        end

        description
      end
    end
  end
end
