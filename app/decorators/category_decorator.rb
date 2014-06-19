class CategoryDecorator < Draper::Decorator
  decorates_association :contents, with: CategoryContentDecorator

  delegate :title, :description

  def path
    h.category_path(object.id)
  end

  def canonical_url
    h.category_url(object.id)
  end

  def alternate_options
    I18n.available_locales.each_with_object({}) do |locale, map|
      map["#{locale}-GB"] = h.category_url(locale: locale)
    end
  end

  def render_contents
    partial = if object.parent?
      'child_categories'
    elsif object.child?
      'content_items'
    end

    h.render partial, contents: contents
  end
end
