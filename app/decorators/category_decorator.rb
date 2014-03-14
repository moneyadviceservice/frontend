class CategoryDecorator < Draper::Decorator
  delegate :title, :description

  def contents
    CategoryContentDecorator.decorate_collection(object.contents || [])
  end

  def path
    h.category_path(object.id)
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
