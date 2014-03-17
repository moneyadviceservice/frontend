class CategoryDecorator < Draper::Decorator
  delegate :title, :description, :canonical_url

  def contents
    CategoryContentDecorator.decorate_collection(object.contents || [])
  end

  def path
    h.category_path(object.id)
  end

  def canonical_url
    h.category_url(object.id)
  end

  def alternate_options
    h.alternate_locales.each_with_object({}) do |locale, map|
      map[locale] = h.category_url(locale: locale)
    end
  end

  def render_contents
    partial = if object.grandparent?
      'parent_categories'
    elsif object.parent?
      'child_categories'
    elsif object.child?
      'content_items'
    end

    h.render partial, contents: contents
  end
end
