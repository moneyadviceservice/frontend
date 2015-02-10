module Core::Repository
  module Categories
    class CMS < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
        self.fallback_repository = options[:fallback]
      end

      def all
        response = connection.get('/%{locale}/categories.json' % { locale: I18n.locale })
        response.body
      rescue
        fallback_repository.all
      end

      def find(id)
        response = connection.get('/%{locale}/categories/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        response.body
      rescue
        fallback_repository.find(id)
      end

      private

      attr_accessor :connection, :fallback_repository
    end
  end
end
