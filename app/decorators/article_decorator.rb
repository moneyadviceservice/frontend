require 'html_processor'

class ArticleDecorator < Draper::Decorator
  delegate :title, :description

  def content
    processed_body.html_safe
  end

  private

  def processed_body
    @processed_body ||= html_processor.process(
      HtmlProcessor::INTRO_IMG,
      HtmlProcessor::ACTION_EMAIL,
      HtmlProcessor::ACTION_FORM
    )
  end

  def html_processor
    @processor ||= HtmlProcessor::NodeRemover.new(object.body)
  end
end
