class CategoryDecorator < Draper::Decorator
  delegate :title, :description

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
    I18n.available_locales.each_with_object({}) do |locale, map|
      map["#{locale}-GB"] = h.category_url(locale: locale)
    end
  end

  def render_contents
    partial = if object.grandparent?
                if Feature.active?(:left_hand_nav)
                  'parent_categories_v2'
                else
                  'parent_categories'
                end

              elsif object.parent?

                if Feature.active?(:left_hand_nav)
                  'child_categories_v2'
                else
                  'child_categories'
                end

              elsif object.child?
                if Feature.active?(:left_hand_nav)
                  'content_items_v2'
                else
                  'content_items'
                end
              end

    h.render partial, contents: contents
  end
end
