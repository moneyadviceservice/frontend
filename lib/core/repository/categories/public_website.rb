module Core::Repository
  module Categories
    class PublicWebsite < Core::Repository::Base
      def initialize
        self.connection = Core::Registry::Connection[:public_website]
      end

      def all
        response = connection.get('/%{locale}/categories.json' %
                                    { locale: I18n.locale })
        response.body
      rescue
        raise RequestError, 'Unable to fetch Categories JSON from Public Website'
      end

      def find(id)
        response = connection.get('/%{locale}/categories/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        response.body
      rescue Core::Connection::Http::ResourceNotFound
        nil
      rescue Core::Connection::Http::ConnectionFailed, Core::Connection::Http::ClientError
        raise RequestError, 'Unable to fetch Category JSON from Public Website'
      end

      private

      attr_accessor :connection
    end
  end
end
