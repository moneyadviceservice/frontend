require 'html_processor'

class ArticleDecorator < Draper::Decorator
  delegate :title, :description

  def content
    processed_body.html_safe
  end

  private

  def processed_body
    @process_body ||= begin
      temp_body = nil
      html_processors.each do |processor, xpaths|
        temp_body = processor.new(temp_body || object.body).process(*xpaths)
      end
      temp_body
    end
  end

  def html_processors
    {
      HTMLProcessor::NodeRemover => [
        HTMLProcessor::INTRO_IMG,
        HTMLProcessor::ACTION_EMAIL,
        HTMLProcessor::ACTION_FORM
      ],
      HTMLProcessor::VideoWrapper => [
        HTMLProcessor::VIDEO_IFRAME
      ]
    }
  end


end
