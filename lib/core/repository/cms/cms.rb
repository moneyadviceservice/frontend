module Core::Repository
  module CMS
    class ResourceElsewhereError < Exception
      attr_reader :location

      def initialize(msg, location)
        super(msg)
        @location = location
      end

      def status
        raise NotImplementedError
      end
    end

    class Resource301Error < ResourceElsewhereError
      def initialize(location)
        super(self.class, location)
      end

      def status
        301
      end
    end

    class Resource302Error < ResourceElsewhereError
      def initialize(location)
        super(self.class, location)
      end

      def status
        302
      end
    end

    class CMS < Core::Repository::Base
      def initialize(options = {})
        self.connection = Core::Registry::Connection[:cms]
      end

      def find(id)
        response = connection.get(resource_url(id))

        if response.status == 301
          raise Core::Repository::CMS::Resource301Error.new(response.headers['Location'])
        elsif response.status == 302
          raise Core::Repository::CMS::Resource302Error.new(response.headers['Location'])
        end

        process_response(response)
      rescue Core::Connection::Http::ResourceNotFound
        nil
      rescue Core::Repository::CMS::Resource301Error,
             Core::Repository::CMS::Resource302Error => e
        raise e
      rescue => e
        raise RequestError, 'Unable to fetch Article JSON from Contento'
      end

      def resource_name
        self.class.name.split('::')[-2].underscore
      end

      private

      def process_response(response)
        AttributeBuilder.build(response)
      end

      def resource_url(id)
        '/api/%{locale}/%{page_type}/%{id}.json' % { locale: I18n.locale, page_type: resource_name, id: id }
      end

      attr_accessor :connection
    end
  end
end
