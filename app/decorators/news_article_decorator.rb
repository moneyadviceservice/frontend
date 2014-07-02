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
    processor = HTMLProcessor::NodeRemover.new(object.body)

    processor.process(HTMLProcessor::IMAGE_AUTHOR)
    processor.process(HTMLProcessor::ACTION_EMAIL)
    processor.process(HTMLProcessor::ACTION_FORM)
  end
end
