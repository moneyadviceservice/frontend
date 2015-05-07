module Core::Repository
  module CMS
    class CMS < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
      end

      def find(id)
        resource_url = '%{locale}/%{page_type}/%{id}.json' % { locale: I18n.locale, page_type: resource_name, id: id }
        response = connection.get(resource_url)
        AttributeBuilder.build(response)
      rescue Core::Connection::Http::ResourceNotFound
        nil
      rescue => e
        raise RequestError, 'Unable to fetch Article JSON from Contento'
      end

      def resource_name
        self.class.name.split('::')[-2].underscore
      end

      private

      attr_accessor :connection
    end
  end
end
