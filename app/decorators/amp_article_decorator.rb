require 'html_processor'

class AmpArticleDecorator < Draper::Decorator

  def initialize(object, options = {})
    super
  end

  def content
    body = object.body

    html_processors.each do |processor, xpaths|
      body = processor.new(body).process(*xpaths)
    end

    body.html_safe
  end

  private

  def html_processors
    [
      [HTMLProcessor::AmpVideo, [HTMLProcessor::VIDEO_IFRAME]]
    ]
  end
end
