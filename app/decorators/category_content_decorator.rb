class CategoryContentDecorator < Draper::Decorator
  decorates_association :contents, with: CategoryContentDecorator

  delegate :id, :title, :description, :category_promos

  def label
    "#{object.type.titleize} - "
  end

  def path
    case object
    when Core::Article, Core::Category
      h.send("#{object.class.to_s.demodulize.underscore}_path", object.id, locale: I18n.locale)
    when Core::Other, Core::Video
      "/#{I18n.locale}/#{object.type.pluralize}/#{object.id}"
    end
  end

  def icon_class
    "icon--#{object.type.dasherize}"
  end

  def category?
    object.type == 'category' || object.type == nil
  end
end
