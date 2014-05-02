require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'
require 'core/repositories/search/google_custom_search_engine_response_mapper'

module Core::Repositories
  module Search
    class GoogleCustomSearchEngine < Core::Repository
      EVENT_NAME = 'request.google_api.search'
      RESULTS_PER_PAGE = 10

      def initialize(key, cx_en, cx_cy)
        self.connection = Core::Registries::Connection[:google_api]
        self.cx_en      = cx_en
        self.cx_cy      = cx_cy
        self.key        = key
      end

      def perform(query, page = 1)
        response = ActiveSupport::Notifications.instrument(EVENT_NAME, query: query, locale: I18n.locale, page: page) do
          start_index = ((page * RESULTS_PER_PAGE) - (RESULTS_PER_PAGE - 1))
          connection.get('customsearch/v1', key: key, cx: localized_cx, q: query, start: start_index)
        end
        GoogleCustomSearchEngineResponseMapper.new(response).mapped_response

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
