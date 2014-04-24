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

  def site_title_regex
    Regexp.new(site_title_suffixes.join('$|'))
  end

  def site_title_suffixes
    title  = h.t('layouts.base.title')
    length = title.length

    length.times.map do |i|
      truncated = i < length -1
      " - #{title[0..i]}" + (truncated ? ' ...' : '')
    end
  end

end
