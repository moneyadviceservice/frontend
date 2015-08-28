module Core::Repository
  module CMS
    class CmsApi < CMS
      private

      def process_response(response)
      end

      def resource_url(id)
        '/api/%{id}.json' % { id: id }
      end

      attr_accessor :connection
    end
  end
end
