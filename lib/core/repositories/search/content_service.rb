require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Search
    class ContentService < Core::Repository
      LIMIT = 25

      def initialize
        self.connection = Core::Registries::Connection[:content_service]
      end

      def perform(query)
        response = connection.get('search.json', query: query, locale: I18n.locale, limit: LIMIT)
        response.body['searchResults'].map do |result_data|
          {
            :id => result_data['id'],
            :title => result_data['preview']['title'],
            :description => result_data['preview']['preview'],
            :type => result_data['type']
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
