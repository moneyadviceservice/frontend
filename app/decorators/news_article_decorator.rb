require 'html_processor'

class NewsArticleDecorator < Draper::Decorator
  delegate :title, :description

  def content
    @content ||= processed_body.html_safe
  end

  private

  def processed_body
    processor = HTMLProcessor::NodeRemover
    processor.new(object.body).process(HTMLProcessor::IMAGE_AUTHOR)
  end
end
