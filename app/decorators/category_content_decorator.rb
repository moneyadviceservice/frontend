class CategoryContentDecorator < Draper::Decorator
  delegate :id, :title, :description

  def label
    "#{object.type.titleize} - "
  end

  def contents
    CategoryContentDecorator.decorate_collection(object.contents || [])
  end

  def path
    case object
    when Core::Article, Core::Category
      h.send("#{object.class.to_s.demodulize.underscore}_path", object.id, locale: I18n.locale)
    when Core::Other
      "/#{I18n.locale}/#{object.type.pluralize}/#{object.id}"
    end
  end

  def icon_class
    "icon--#{object.type.dasherize}"
  end
end
