class CorporateCategoryContentDecorator < CategoryContentDecorator
  def path
    case object
    when Core::Article, Mas::Cms::Article
      h.send("#{object.class.to_s.demodulize.underscore}_path",
             object.id,
             locale: I18n.locale)
    when Core::Category, Mas::Cms::Category
      h.send("corporate_#{object.class.to_s.demodulize.underscore}_path",
             object.id,
             locale: I18n.locale)
    when Core::Other, Mas::Cms::Other, Mas::Cms::Video
      "/#{I18n.locale}/#{object.type.pluralize}/#{object.id}"
    end
  end
end
