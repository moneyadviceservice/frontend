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

  def related_categories(qty = 8)
    # First pull together a hash of categories and articles, in the process
    # filtering out the current article's entry from the contents.
    data = object.categories.each_with_object({}) do |cat, obj|
      contents = cat.contents.reject { |a| a == object }
      obj[cat] = contents if contents.present?
    end

    # Now gather another hash with categories as keys, but with
    # qty articles taken as evenly as possible from each category.
    entities = {}
    loop_count = 0
    push_count = 0

    while push_count < qty && loop_count < qty do
      data.each do |cat, contents|
        if (next_item = contents.shift)
          entities[cat] ||= []
          entities[cat] << next_item
          push_count += 1
        end
        break if push_count >= qty
      end
      loop_count += 1
    end

    # Finally, decorate the entities
    entities.each_with_object({}) do |(cat, contents), object|
      object[CategoryDecorator.decorate(cat)] = CategoryContentDecorator.decorate_collection(contents)
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
