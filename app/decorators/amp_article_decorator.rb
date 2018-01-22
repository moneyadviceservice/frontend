require 'html_processor'

class AmpArticleDecorator < Draper::Decorator
  include ActionView::Helpers::OutputSafetyHelper
  def initialize(object, options = {})
    super
  end

  def content
    body = object.body

    html_processors.each do |processor, xpaths|
      body = processor.new(body).process(*xpaths)
    end

    safe_join([body.html_safe])
  end

  private

  def html_processors
    [
      [HTMLProcessor::AmpVideo,  [HTMLProcessor::VIDEO_IFRAME]],
      [HTMLProcessor::AmpImg,    [HTMLProcessor::IMG]],
      [HTMLProcessor::AmpIframe, [HTMLProcessor::NON_VIDEO_IFRAME]]
    ]
  end
end
