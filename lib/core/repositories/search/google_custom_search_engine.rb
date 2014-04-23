require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'
require 'core/repositories/search/google_custom_search_engine_response_mapper'

module Core::Repositories
  module Search
    class GoogleCustomSearchEngine < Core::Repository
      EVENT_NAME = 'request.google_api.search'

      def initialize(key, cx_en, cx_cy)
        self.connection = Core::Registries::Connection[:google_api]
        self.cx_en      = cx_en
        self.cx_cy      = cx_cy
        self.key        = key
      end

      def perform(query)
        mapper   = GoogleCustomSearchEngineResponseMapper.new
        response = connection.get('customsearch/v1', key: key, cx: localized_cx, q: query)

        mapper.map(response)

      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
      end

      private

      attr_accessor :connection, :cx_en, :cx_cy, :key

      def localized_cx
        send("cx_#{I18n.locale}")
      end

    end
  end
end
