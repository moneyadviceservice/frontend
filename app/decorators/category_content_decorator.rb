class CategoryContentDecorator < Draper::Decorator
  delegate :id, :title, :description

  def label
    "#{object.type.titleize} - "
  end

  def contents
    CategoryContentDecorator.decorate_collection(object.contents || [])
  end

  def path
    case object.class.to_s
      when 'Core::Article'
        h.article_path(object.id, locale: I18n.locale)
      when 'Core::ActionPlan'
        h.action_plan_path(object.id, locale: I18n.locale)
      when 'Core::Category'
        h.category_path(object.id, locale: I18n.locale)
      when 'Core::Other'
        "/#{I18n.locale}/#{object.type.pluralize}/#{object.id}"
    end
  end

  def icon_class
    "icon--#{object.type.dasherize}"
  end
end
