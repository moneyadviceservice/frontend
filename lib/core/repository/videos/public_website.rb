module Core::Repository
  module Videos
    class PublicWebsite < Core::Repository::Base
      def initialize
        self.connection = Core::Registry::Connection[:public_website]
      end

      def find(id)
        response = connection.get(
          '/%{locale}/videos/%{id}.json' %
          { locale: I18n.locale, id: id }
        )

        response.body
      rescue Core::Connection::Http::ResourceNotFound
        nil
      rescue Core::Connection::Http::ConnectionFailed, Core::Connection::Http::ClientError
        raise RequestError, 'Unable to fetch Video JSON from Public Website'
      end

      private

      attr_accessor :connection
    end
  end
end
