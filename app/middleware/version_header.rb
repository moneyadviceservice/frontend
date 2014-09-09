class VersionHeader
  def initialize(app)
    @app = app

    version_file = File.join(Rails.root, 'public', 'version')
    return unless File.exist?(version_file)

    json = File.read(version_file)
    @version = JSON.parse(json)['version']
  end

  def call(env)
    status, headers, body = @app.call(env)

    headers.merge!('X-Mas-Version' => @version) if @version

    [status, headers, body]
  end
end
