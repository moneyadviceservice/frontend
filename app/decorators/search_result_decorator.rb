class SearchResultDecorator < Draper::Decorator
  delegate :title, :description

  def path
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

end
