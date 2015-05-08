module Core::Repository
  module Categories
    class CMS < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
      end

      def all
        response = connection.get('/%{locale}/categories.json' % { locale: I18n.locale })
        response.body
      rescue
        raise RequestError, 'Unable to fetch Category JSON from Contento'
      end

      def find(id)
        response = connection.get('/%{locale}/categories/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        response.body
      rescue
        raise RequestError, 'Unable to fetch Category JSON from Contento'
      end

      private

      attr_accessor :connection
    end
  end
end
