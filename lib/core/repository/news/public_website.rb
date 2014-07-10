module Core::Repository
  module News
    class PublicWebsite < Core::Repository::Base
      def initialize
        self.connection = Core::Registry::Connection[:public_website]
      end

      def find(id)
        response = connection.get('/%{locale}/news/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        attributes = response.body
        links      = response.headers['link'].try(:links) || []

        attributes['alternates'] = []
        links.each do |link|
          next unless link['rel'] == 'alternate'

          attributes['alternates'] << { url: link.href, title: link['title'], hreflang: link['hreflang'] }
        end

        attributes

      rescue Core::Connection::ResourceNotFound
        nil
      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch News JSON from Public Website'
      end

      def all(page=1)
        response = connection.get('/%{locale}/news.json?page_number=%{page}' % {locale: I18n.locale, page: page})
        response.body
      rescue
        raise RequestError, 'Unable to fetch News JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
