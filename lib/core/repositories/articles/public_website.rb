require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Articles
    class PublicWebsite < Core::Repository
      def initialize
        self.connection = Core::Registries::Connection[:public_website]
      end

      def find(id)
        response = connection.get('/%{locale}/articles/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        response.body
      rescue Core::Connection::ResourceNotFound
        nil
      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Article JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
