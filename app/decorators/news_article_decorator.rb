require 'html_processor'

class NewsArticleDecorator < ContentItemDecorator
  delegate :description


  def initialize(object, options = {})
    super
    processors << [HTMLProcessor::NodeRemover, [HTMLProcessor::IMAGE_AUTHOR]]
  end

  def date(options={})
    h.l(object.date, format: options.fetch(:format, :short))
  end

  def intro
    processor = HTMLProcessor::NodeContents
    processor.new(object.body).process(HTMLProcessor::INTRO_PARAGRAPH).html_safe
  end

  def path
    h.news_article_path(object.id)
  end
end
