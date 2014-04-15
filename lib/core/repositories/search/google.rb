require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Search
    class Google < Core::Repository
      EVENT_NAME = 'request.google_api.search'
      SECOND_TO_LAST = -2

      def initialize
        self.connection = Core::Registries::Connection[:google_api]
      end

      def perform(query)
        options = { key: ENV['GOOGLE_API_KEY'], cx: ENV['GOOGLE_API_CX'], q: query }
        response = connection.get('customsearch/v1', options)
        map_response(response)

      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
      end

      private

      attr_accessor :connection

      def map_response(response)
        items = response.body.fetch('items', [])
        items.map do |result_data|
          {
            id:          result_data['link'].split('/').last,
            type:        result_data['link'].split('/')[SECOND_TO_LAST].singularize,
            description: extract_description(result_data['pagemap']['metatags']),
            title:       result_data['title']
          }
        end
      end

      def extract_description(metatags_array)
        description = ''
        metatags_array.each do |metatags|
          metatags.each { |key, value| return description = value if key == 'og:description' }
        end

        description
      end
    end
  end
end
