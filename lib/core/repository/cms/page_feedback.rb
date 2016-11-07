module Core
  module Repository
    module CMS
      class PageFeedback < ::Core::Repository::CMS::CMS
        def create(params)
          request(:post, params)
        end

        def update(params)
          request(:patch, params)
        end

        def request(verb, params)
          response = connection.send(verb, resource_url(params), params)
          response.body
        rescue
          false
        end

        def resource_url(params)
          '/api/%{locale}/%{slug}/page_feedbacks' % {
            locale: params[:locale],
            slug: params[:article_id]
          }
        end
      end
    end
  end
end
