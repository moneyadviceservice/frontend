require 'link_header'

class Faraday::Response::LinkHeader < Faraday::Middleware
  def call(env)
    @app.call(env).on_complete do
      response_headers = env[:response_headers]

      link_header = response_headers['Link']
      response_headers['Link'] = (LinkHeader.parse(link_header) if link_header)
    end
  end
end

Faraday::Response.register_middleware link_header: Faraday::Response::LinkHeader
