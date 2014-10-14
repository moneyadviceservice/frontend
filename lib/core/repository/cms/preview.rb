module Core::Repository
  module CMS
    class Preview < Core::Repository::Base
      def initialize(_options = {})
        self.connection = Core::Registry::Connection[:cms]
      end

      def find(id)
        response = connection.get('preview/%{locale}/%{id}.json' % { id: id, locale: I18n.locale })
        AttributeBuilder.build(response)
      rescue Core::Connection::Http::ResourceNotFound
        nil
      rescue Core::Connection::Http::ConnectionFailed, Core::Connection::Http::ClientError
        raise RequestError, 'Unable to fetch Article JSON from CMS'
      end

      private

      attr_accessor :connection
    end
  end
end
