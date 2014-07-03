require 'html_processor'

class NewsArticleDecorator < ContentItemDecorator

  def date(options={})
    h.l(object.date, format: options.fetch(:format, :short))
  end

  def content
    processor = HTMLProcessor::NodeRemover
    processor.new(object.body).process(HTMLProcessor::IMAGE_AUTHOR).html_safe
  end

  def intro
    processor = HTMLProcessor::NodeContents
    processor.new(object.body).process(HTMLProcessor::INTRO_PARAGRAPH)
  end
end
