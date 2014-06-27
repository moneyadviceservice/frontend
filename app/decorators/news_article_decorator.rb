require 'html_processor'

class NewsArticleDecorator < ContentItemDecorator
  def date
    @date || formatted_date
  end

  def content
    processed_body.html_safe
  end

  private

  def formatted_date
    date = DateTime.parse(object.date)
    date.strftime("%d %b %Y")
  end

  def processed_body
    processor = HTMLProcessor::NodeRemover
    processor.new(object.body).process(HTMLProcessor::IMAGE_AUTHOR)
  end
end
