class PartnerToolsCookies
  COOKIE_SEPARATOR = "\n".freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if (headers['Set-Cookie'].present? || env['HTTP_SET_COOKIE'].present?) && Rack::Request.new(env).ssl?
      cookie = headers['Set-Cookie'] || env['HTTP_SET_COOKIE']
      cookies = cookie.split(COOKIE_SEPARATOR)

      cookies.each do |cookie|
        next if cookie.blank?

        cookie << '; SameSite=None'
      end

      headers['Set-Cookie'] = cookies.join(COOKIE_SEPARATOR)
    end

    [status, headers, body]
  end
end
