module Core
  module Repository
    module CMS
      class PageFeedback < ::Core::Repository::CMS::CMS
        def create(params)
          response = connection.post(resource_url(params), params)
          response.body
        rescue Core::Connection::Http::ClientError
          false
        end

        def resource_url(params)
          '/api/%{slug}/page_feedbacks' % { slug: params[:article_id] }
        end
      end
    end
  end
end
