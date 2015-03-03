class CorporateDecorator < ContentItemDecorator
  attr_reader :extra_content_path
  delegate :lookup_context, to: :h

  def initialize(*)
    super

    @extra_content_path = 'corporate/extra'
  end

  def extra_content_partial
    "#{extra_content_path}/#{extra_content_partial_name}"
  end

  def extra_content?
    path = Array(extra_content_path)

    lookup_context.template_exists?(extra_content_partial_name, path, true)
  end

  private

  def extra_content_partial_name
    slug.underscore
  end
end
