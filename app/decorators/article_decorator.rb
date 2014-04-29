require 'html_processor'

class ArticleDecorator < Draper::Decorator
  delegate :title, :description

  def alternate_options
    object.alternates.each_with_object({}) do |alternate, hash|
      hash[alternate.hreflang] = alternate.url
    end
  end

  def footer_alternate_options
    Hash[alternate_options.map { |key, value| [key.scan(/\w+/).first, value] }].except(I18n.locale.to_s)
  end

  def canonical_url
    h.article_url(object.id)
  end

  def content
    @content ||= HTMLProcessor::NodeRemover.new(processed_body).process(HTMLProcessor::INTRO_PARAGRAPH).html_safe
  end

  def intro
    @intro ||= HTMLProcessor::NodeContents.new(processed_body).process(HTMLProcessor::INTRO_PARAGRAPH).html_safe
  end

  def parent_categories
    @parent_categories ||= CategoryDecorator.decorate_collection(object.categories)
  end

  def related_categories
    @related_categories ||= object.categories.each_with_object([]) do |category, obj|
      # Remove the article from the category's contents collection
      category.contents.reject! { |a| a == object }
      # Now only include the category if there are still contents
      obj << CategoryDecorator.decorate(category) if category.contents.present?
    end
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
