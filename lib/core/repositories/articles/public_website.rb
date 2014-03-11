require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Articles
    class PublicWebsite < Core::Repository
      def initialize
        self.connection = Core::Registries::Connection[:public_website]
      end

      def find(id)
        response = connection.get('/%{locale}/articles/%{id}.json' %
                                    { locale: I18n.locale, id: id })

        attributes = response.body
        links      = response.headers['link'].try(:links) || []

        links.each do |link|
          next unless link['rel'] == 'alternate'

          attributes['alternate'] = { url: link.href, title: link['title'] }
        end

        attributes

      rescue Core::Connection::ResourceNotFound
        nil
      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Article JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
