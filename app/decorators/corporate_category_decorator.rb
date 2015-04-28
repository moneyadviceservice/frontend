class CorporateCategoryDecorator < CategoryDecorator
  delegate :third_level_navigation

  def render_contents
    partial = if object.parent?
                parent_partial_path
              elsif object.child?
                child_partial_path
              end

    h.render partial, contents: contents
  end

  private

  def parent_partial_path
    if self.object.third_level_navigation
      'child_categories'
    else
      'categories/child_categories'
    end
  end

  def child_partial_path
    if self.object.third_level_navigation
      'content_items'
    else
      'categories/content_items'
    end
  end
end
