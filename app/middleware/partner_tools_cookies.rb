class PartnerToolsCookies
  COOKIE_SEPARATOR = "\n".freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    (headers['Set-Cookie'].present? || env['HTTP_SET_COOKIE'].present?) &&
      Rack::Request.new(env).ssl?

    cookie = headers['Set-Cookie'] || env['HTTP_SET_COOKIE']
    cookies = cookie.split(COOKIE_SEPARATOR)

    cookies.each do |cookie|
      next if cookie.blank?
      next if cookie =~ /;\s*secure/i

      cookie << '; Secure; SameSite=None'
    end

    headers['Set-Cookie'] = cookies.join(COOKIE_SEPARATOR)

    [status, headers, body]
  end
end
