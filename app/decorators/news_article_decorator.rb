require 'html_processor'

class NewsArticleDecorator < ContentItemDecorator
  def date(options={})
    h.l(object.date, format: options.fetch(:format, :short))
  end

  def content
    processed_body.html_safe
  end

  private

  def processed_body
    processor = HTMLProcessor::NodeRemover
    processor.new(object.body).process(HTMLProcessor::IMAGE_AUTHOR)
  end
end
