require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Search
    class PublicWebsite < Core::Repository
      def initialize
        self.connection = Core::Registries::Connection[:public_website]
      end

      def perform(query)
        response = connection.get(('/%{locale}/search' %
                                    { locale: I18n.locale }), query: query)
        response.body
      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
