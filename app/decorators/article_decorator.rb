require 'html_processor'

class ArticleDecorator < Draper::Decorator
  delegate :title, :description

  def content
    processed_body.html_safe
  end

  private

  def processed_body
    @processed_body ||= html_processor.process(
      HTMLProcessor::INTRO_IMG,
      HTMLProcessor::ACTION_EMAIL,
      HTMLProcessor::ACTION_FORM
    )
  end

  def html_processor
    @processor ||= HTMLProcessor::NodeRemover.new(object.body)
  end
end
