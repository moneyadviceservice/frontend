module Core::Repository
  module Articles
    class PublicWebsite < Core::Repository::Base
      def initialize
        self.connection = Core::Registry::Connection[:public_website]
      end

      def find(id)
        response = connection.get('/%{locale}/articles/%{id}.json' %
                                    { locale: I18n.locale, id: id })

        attributes = response.body
        links      = response.headers['link'].try(:links) || []

        attributes['alternates'] = []
        links.each do |link|
          next unless link['rel'] == 'alternate'

          attributes['alternates'] << { url: link.href, title: link['title'], hreflang: link['hreflang'] }
        end

        attributes

      rescue Core::Connection::Http::ResourceNotFound
        nil
      rescue Core::Connection::Http::ConnectionFailed, Core::Connection::Http::ClientError
        raise RequestError, 'Unable to fetch Article JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
