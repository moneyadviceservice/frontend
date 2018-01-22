class CategoryContentDecorator < Draper::Decorator
  decorates_association :contents, with: CategoryContentDecorator

  delegate :id, :title, :description, :category_promos

  def initial_contents
    contents.take(3)
  end

  def extended_contents
    contents[3..-1] || []
  end

  def label
    "#{object.type.titleize} - "
  end

  #TODO: Remove Core type checks when they have been removed
  def path
    case object
    when Core::Article, Core::Category, Mas::Cms::Article, Mas::Cms::Category
      h.send("#{object.class.to_s.demodulize.underscore}_path", object.id, locale: I18n.locale)
    when Core::Other, Core::Video, Mas::Cms::Other, Mas::Cms::Video
      "/#{I18n.locale}/#{object.type.pluralize}/#{object.id}"
    end
  end

  def icon_class
    "icon--#{object.type.dasherize}"
  end

  def category?
    object.type == 'category' || object.type.nil?
  end
end
