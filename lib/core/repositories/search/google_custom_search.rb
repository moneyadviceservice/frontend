require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'
require 'core/repositories/search/google_custom_search_response_mapper'

module Core::Repositories
  module Search
    class GoogleCustomSearch < Core::Repository
      EVENT_NAME = 'request.google_api.search'

      def initialize(key, cx)
        self.connection = Core::Registries::Connection[:google_api]
        self.cx         = cx
        self.key        = key
      end

      def perform(query)
        mapper   = GoogleCustomSearchResponseMapper.new
        response = connection.get('customsearch/v1', key: key, cx: cx, q: query)

        mapper.map(response)

      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
      end

      private

      attr_accessor :connection, :cx, :key

    end
  end
end
