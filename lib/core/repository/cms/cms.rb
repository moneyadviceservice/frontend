module Core::Repository
  module CMS
    class CMS < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
        self.fallback_repository = options[:fallback]
      end

      def find(id)
        response = connection.get('%{locale}/%{id}.json' % { locale: I18n.locale, id: id })
        AttributeBuilder.build(response)
      rescue
        fallback_repository.find(id)
      end

      private

      attr_accessor :connection, :fallback_repository
    end
  end
end
