module Core::Repository
  module Footer
    class CMS < ::Core::Repository::CMS::CMS
      def find(id)
        footer_url = '/api/%{locale}/%{id}.json' % { locale: I18n.locale, id: id }
        response = connection.get(footer_url)
        response.body
      rescue => e
        raise RequestError,
              'Unable to fetch Footer JSON from Contento' +
              " error: [#{e.inspect}]" +
              " url_prefix: [#{connection.try(:url_prefix).inspect}]"
      end
    end
  end
end
