require 'html_processor'

class NewsArticleDecorator < Draper::Decorator
  delegate :title, :description

  def content
    @content ||= processed_body.html_safe
  end

  def date
    @date || formatted_date
  end

  private

  def processed_body
    processor = HTMLProcessor::NodeRemover
    processor.new(object.body).process(HTMLProcessor::IMAGE_AUTHOR)
  end

  def formatted_date
    date = DateTime.parse(object.date)
    date.strftime("%d %b %Y")
  end
end
