module Core
  module Repository
    module CMS
      class PageFeedback < ::Core::Repository::CMS::CMS
        MAS_CMS_API_TOKEN = ENV.fetch('MAS_CMS_API_TOKEN')

        def create(params)
          request(:post, params)
        end

        def update(params)
          request(:patch, params)
        end

        def request(verb, params)
          connection.token_auth(MAS_CMS_API_TOKEN)
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
