module Core::Repository
  module CMS
    class Preview < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
      end

      def find(id)
        response = connection.get('preview/%{id}.json' % { id: id })
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
