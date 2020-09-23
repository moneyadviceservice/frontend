class PartnerToolsCookies
  COOKIE_SEPARATOR = "\n".freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    cookie = headers['Set-Cookie'] || env['HTTP_SET_COOKIE']
    unless cookie.nil?
      cookies = cookie.split(COOKIE_SEPARATOR)

      cookies.each do |cookie|
        next if cookie.blank?
        next if cookie =~ /;\s*secure/i

        cookie << '; Secure; SameSite=None'
      end

      headers['Set-Cookie'] = cookies.join(COOKIE_SEPARATOR)
    end

    [status, headers, body]
  end
end
