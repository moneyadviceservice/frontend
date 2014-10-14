class OptimizelyScript
  def to_s
    config_file.present? ? script_tag : ''
  end

  private

  def config
    JSON.parse(config_file.read)
  rescue
    {}
  end

  def config_file
    @_config_file ||= (File.open(config_path, 'r') if File.exist?(config_path))
  end

  def config_path
    '/var/lib/optimizely_refresh/version'
  end

  def script_tag
    %(<script src="#{url}"></script>)
  end

  def url
    "#{path}/#{config['digest']}.js"
  end

  def path
    '/a/optimizely'
  end
end
