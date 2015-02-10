module Core::Repository
  module CMS
    class CMS < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
        self.fallback_repository = options[:fallback]
      end

      def find(id)
        resource_url = '%{locale}/%{page_type}/%{id}.json' % { locale: I18n.locale, page_type: resource_name, id: id }
        response = connection.get(resource_url)
        AttributeBuilder.build(response)
      rescue => e
        Rails.logger.error("Tried to fetch from Contento. Error message: #{e.message}")
        fallback_repository.find(id)
      end

      def resource_name
        self.class.name.split('::')[-2].underscore
      end

      private

      attr_accessor :connection, :fallback_repository
    end
  end
end
