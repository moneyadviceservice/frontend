module Core::Repository
  module Search
    class ContentService < Core::Repository::Base
      LIMIT      = 25
      EVENT_NAME = 'request.content-service.search'

      def initialize
        self.connection = Core::Registry::Connection[:content_service]
      end

      def perform(query)
        options  = { query: query, locale: I18n.locale, limit: LIMIT }
        response = ActiveSupport::Notifications.instrument(EVENT_NAME, options) do
          connection.get('search.json', options)
        end

        response.body['searchResults'].map do |result_data|
          {
            :id          => result_data['id'],
            :title       => result_data['preview']['title'],
            :description => result_data['preview']['preview'] || result_data['preview']['description'],
            :type        => result_data['type']
          }
        end
      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results JSON from Content Service'
      end

      private

      attr_accessor :connection

    end
  end
end
