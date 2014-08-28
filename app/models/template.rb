if Rails.env.development?
  require_dependency 'campaign_page/campaign'
  require_dependency 'campaign_page/section'
  require_dependency 'campaign_page/article'
end

class Template
  class TemplateNotFound < StandardError; end

  attr_accessor :path
  private :path

  def initialize(options = {})
    self.path = options.fetch(:path, Rails.root.join('app', 'templates'))
  end

  def build_campaign(id)
    YAML.load_file(File.join(path, "#{id}.yml"))
  rescue Errno::ENOENT
    raise TemplateNotFound
  end
end
