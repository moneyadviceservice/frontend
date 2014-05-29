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
    @parent_categories ||= CategoryDecorator.decorate_collection(categories)
  end

  def related_categories(quantity = 6)
    limited_parent_categories_with_contents(quantity).
      each_with_object({}) do |(category, contents), hash|
        hash[CategoryDecorator.decorate(category)] = CategoryContentDecorator.decorate_collection(contents)
      end
  end

  private

  def categories
    object.categories.compact
  end

  def limited_parent_categories_with_contents(limit = 6)
    # Need to assign the output of #contents_by_category to a var as we will
    # be shifting elements out of and modifyingit's values as we iterate.
    contents_hash = parent_categories_with_contents

    {}.tap do |limited_contents_hash|
      catch :limit_reached do
        until contents_hash.values.all?(&:empty?) do
          contents_hash.each do |category, contents|
            if (next_item = contents.shift)
              limited_contents_hash[category] ||= []
              limited_contents_hash[category] << next_item
            end

            throw :limit_reached if limited_contents_hash.values.flatten.count >= limit
          end
        end
      end
    end
  end

  def parent_categories_with_contents
    categories.each_with_object({}) do |category, hash|
      contents = category.contents.reject { |a| a == object }
      hash[category] = contents if contents.present?
    end
  end

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
