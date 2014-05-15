class SearchResultDecorator < Draper::Decorator
  delegate :description

  def to_partial_path
    'search_result'
  end

  def path
    return object.link if defined?(object.link)

    case object.type
      when 'article', 'guide'
        h.article_path(object.id, locale: I18n.locale)
      when 'action-plan'
        h.action_plan_path(object.id, locale: I18n.locale)
      when 'category'
        h.category_path(object.id, locale: I18n.locale)
      when 'campaign', 'news', 'tool', 'video'
        "/#{I18n.locale}/#{object.type.pluralize}/#{object.id}"
    end
  end

  def title
    object.title.sub(site_title_regex, '')
  end

  private

  def make_optional(string)
    head = string.first
    tail = string[1..-1]

    if tail
      "(#{head}#{make_optional(tail)})?"
    else
      ''
    end
  end

  def site_title_regex
    title = h.t('layouts.base.title')
    Regexp.new("( - #{make_optional(title)}( \.\.\.)?)?$")
  end
end
