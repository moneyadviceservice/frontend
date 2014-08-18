module Core::Repository
  module CMS
    class CMS < Core::Repository::Base
      def initialize(options={})
        self.connection = Core::Registry::Connection[:cms]
        self.fallback_repository = options[:fallback]
      end

      def find(id)
        response = connection.get('%{id}.json' % { locale: I18n.locale, id: id })

        attributes = response.body

        attributes['title']      = attributes['label']
        attributes['body']       = BlockComposer.new(attributes['blocks']).to_html
        attributes['categories'] = attributes['category_names']
        attributes['alternates'] = []

        attributes

      rescue
        fallback_repository.find(id)
      end

      private

      attr_accessor :connection, :fallback_repository
    end
  end
end
