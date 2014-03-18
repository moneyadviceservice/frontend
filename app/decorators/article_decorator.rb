require 'html_processor'

class ArticleDecorator < EntityDecorator
  delegate :title, :description

  def alternate_options
    return {} unless object.alternate.present?

    { object.alternate.hreflang => object.alternate.url }
  end

  def content
    @content ||= processed_body.html_safe
  end

  private

  def processed_body
    body = object.body

    html_processors.each do |processor, xpaths|
      body = processor.new(body).process(*xpaths)
    end

    body
  end

  def html_processors
    {
      HTMLProcessor::NodeRemover  => [HTMLProcessor::INTRO_IMG,
                                      HTMLProcessor::ACTION_EMAIL,
                                      HTMLProcessor::ACTION_FORM,
                                      HTMLProcessor::COLLAPSIBLE_SPAN
      ],

      HTMLProcessor::VideoWrapper => [HTMLProcessor::VIDEO_IFRAME],

      HTMLProcessor::TableWrapper => [HTMLProcessor::DATATABLE_DEFAULT]
    }
  end
end
